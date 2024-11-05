package apps

import (
	"context"
	"fmt"
	"log/slog"

	appsruntime "github.com/Anna-Karenina/sme-engine/internal/app/apps_runtime"
	"github.com/Anna-Karenina/sme-engine/internal/domain/models"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

const op = "apps.service"
const DefaultNodeJsVersion = "v20.14.0"

type Apps struct {
	log        *slog.Logger
	appCRUD    AppCRUD
	appActions AppActions
	envService EnvService
}

type EnvService interface {
	ParseAppPkgJson(appPath string) (*models.AppPkgJson, error)
	ParseProjectNodeJsVersionFile(appPath string) (string, error)
	UpdateNodejsVersionInRcFile(ctx context.Context, filePath string, version string) error
	CheckAppPathIsExist(ctx context.Context, appPath string) (bool, error)
}

type AppActions interface {
	RunApp(ctx context.Context, payload *appsruntime.RunAppPayload) (*appsruntime.AppRuntime, error)
	StopApp(ctx context.Context, id int) (*appsruntime.AppRuntime, error)
}

type AppCRUD interface {
	Create(ctx context.Context, path string, name string) (*models.Node, error)
	Read(ctx context.Context, id int) (*models.Node, error)
	Update(ctx context.Context, in *models.Node) (*models.Node, error)
	GetAllApps(ctx context.Context) ([]*models.Node, error)
	InternalGetNodeById(cxt context.Context, id int) (*models.Node, error)
}

func New(log *slog.Logger, appCRUD AppCRUD, appActions AppActions, envService EnvService) *Apps {
	return &Apps{
		log:        log,
		appCRUD:    appCRUD,
		appActions: appActions,
		envService: envService,
	}
}

func (n *Apps) CreateApp(ctx context.Context, path string, name string) (*models.Node, error) {

	log := n.log.With(slog.String("op", op), slog.String(".path", path), slog.String(".name", name))
	log.Info("creating new node")

	if len(path) == 0 {
		return &models.Node{}, status.Errorf(
			codes.InvalidArgument,
			fmt.Sprintf("Field path didn't provided"),
		)
	}

	node, err := n.appCRUD.Create(ctx, path, name)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	pathExist, err := n.envService.CheckAppPathIsExist(ctx, path)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	if pathExist {
		node.IsAppValid = pathExist
		pkgInfo, err := n.envService.ParseAppPkgJson(path)
		if err != nil {
			return nil, fmt.Errorf("%s: %w", op, err)
		}

		defaultNodeJsVersion, err := n.envService.ParseProjectNodeJsVersionFile(path)
		if err != nil {
			defaultNodeJsVersion = DefaultNodeJsVersion
		}

		node.NodeJsVersion = defaultNodeJsVersion
		node.Scripts = pkgInfo.Scripts

		node, err = n.appCRUD.Update(ctx, node)
		if err != nil {
			return nil, fmt.Errorf("%s: %w", op, err)
		}
	} else {
		node.IsAppValid = pathExist
	}

	log.Info("created node:", slog.String("path", path))

	return node, nil
}

func (n *Apps) ReadApp(ctx context.Context, id int) (*models.Node, error) {
	log := n.log.With(slog.String("op", op), slog.Int(".id", id))
	log.Info("try read node data")

	node, err := n.appCRUD.Read(ctx, id)

	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	pathExist, err := n.envService.CheckAppPathIsExist(ctx, node.Path)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	node.IsAppValid = pathExist

	return node, nil
}

func (n *Apps) ReadAllApps(ctx context.Context) ([]*models.Node, error) {
	log := n.log.With(slog.String("op", op))
	log.Info("getting all nodes")

	nodes, err := n.appCRUD.GetAllApps(ctx)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}
	return nodes, nil
}

func (n *Apps) RunApp(ctx context.Context, payload *appsruntime.RunAppPayload) (*appsruntime.AppRuntime, error) {
	log := n.log.With(slog.String("op", op))
	log.Info("try start node")

	node, err := n.appActions.RunApp(ctx, payload)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	return node, nil
}

func (n *Apps) StopApp(ctx context.Context, id int) (*appsruntime.AppRuntime, error) {
	const op = "App.StopApp"
	log := n.log.With(slog.String("op", op))
	log.Info("try stop node")

	node, err := n.appActions.StopApp(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	return node, nil
}

func (n *Apps) SyncAppScripts(ctx context.Context, id int) (*models.Node, error) {
	log := n.log.With(slog.String("op", op))
	log.Info("sync node scripts")

	node, err := n.appCRUD.Read(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	scripts, err := n.envService.ParseAppPkgJson(node.Path)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	node.Scripts = scripts.Scripts
	node, err = n.appCRUD.Update(ctx, node)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}
	return node, nil
}

func (n *Apps) UpdateAppDefaultNodeJsVerion(ctx context.Context, id int, version string, updateNvmrc bool) (string, error) {

	node, err := n.appCRUD.InternalGetNodeById(ctx, id)
	if err != nil {
		return "", fmt.Errorf("%s: %w", op, err)
	}

	node.NodeJsVersion = version
	node, err = n.appCRUD.Update(ctx, node)
	if err != nil {
		return "", fmt.Errorf("%s: %w", op, err)
	}

	if updateNvmrc {
		err = n.envService.UpdateNodejsVersionInRcFile(ctx, node.Path, version)
		if err != nil {
			return "", fmt.Errorf("%s: %w", op, err)
		}
	}

	return "ok", nil
}

func (n *Apps) UpdateDefaultRunScript(ctx context.Context, id int, script string) (*models.Node, error) {
	const op = "NODE.UpdateDefaultRunScript"
	log := n.log.With(
		slog.String("op", op),
		slog.Int("Id", id),
		slog.String(".Script", script))

	log.Info("trying update default run script")

	node, err := n.appCRUD.InternalGetNodeById(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	node.DefaultScript = script
	node, err = n.appCRUD.Update(ctx, node)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}
	return node, nil
}
