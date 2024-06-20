package nodes

import (
	"context"
	"fmt"
	"log/slog"

	appsruntime "github.com/Anna-Karenina/sme-engine/internal/app/apps_runtime"
	"github.com/Anna-Karenina/sme-engine/internal/domain/models"
)

const op = "nodes.service"

type Node struct {
	log         *slog.Logger
	nodeCRUD    NodeCRUD
	nodeActions NodeActions
	envService  EnvService
}

type EnvService interface {
	ParseAppPkgJson(appPath string) (*models.AppPkgJson, error)
	ParseProjectNodeJsVersionFile(appPath string) (string, error)
	UpdateNodejsVersionInRcFile(ctx context.Context, filePath string, version string) error
	CheckAppPathIsExist(ctx context.Context, appPath string) (bool, error)
}

type NodeActions interface {
	RunNode(ctx context.Context, payload *appsruntime.RunNodePayload) (*appsruntime.AppRuntime, error)
	StopNode(ctx context.Context, id int) (*appsruntime.AppRuntime, error)
}

type NodeCRUD interface {
	Create(ctx context.Context, path string, name string) (*models.Node, error)
	Read(ctx context.Context, id int) (*models.Node, error)
	Update(ctx context.Context, in *models.Node) (*models.Node, error)
	GetAllNodes(ctx context.Context) ([]*models.Node, error)
	InternalGetNodeById(cxt context.Context, id int) (*models.Node, error)
}

func New(log *slog.Logger, crudNode NodeCRUD, nodeActions NodeActions, envService EnvService) *Node {
	return &Node{
		log:         log,
		nodeCRUD:    crudNode,
		nodeActions: nodeActions,
		envService:  envService,
	}
}

func (n *Node) CreateNode(ctx context.Context, path string, name string) (*models.Node, error) {

	log := n.log.With(slog.String("op", op), slog.String(".path", path), slog.String(".name", name))

	log.Info("creating new node")

	node, err := n.nodeCRUD.Create(ctx, path, name)
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
			defaultNodeJsVersion = "v20.14.0"
		}

		node.NodeJsVersion = defaultNodeJsVersion
		node.Scripts = pkgInfo.Scripts

		node, err = n.nodeCRUD.Update(ctx, node)
		if err != nil {
			return nil, fmt.Errorf("%s: %w", op, err)
		}
	} else {
		node.IsAppValid = pathExist
	}

	log.Info("created node:", slog.String("path", path))

	return node, nil
}

func (n *Node) ReadNode(ctx context.Context, id int) (*models.Node, error) {
	log := n.log.With(slog.String("op", op), slog.Int(".id", id))
	log.Info("try read node data")

	node, err := n.nodeCRUD.Read(ctx, id)

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

func (n *Node) ReadAllNodes(ctx context.Context) ([]*models.Node, error) {
	log := n.log.With(slog.String("op", op))
	log.Info("getting all nodes")

	nodes, err := n.nodeCRUD.GetAllNodes(ctx)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}
	return nodes, nil
}

func (n *Node) RunNode(ctx context.Context, payload *appsruntime.RunNodePayload) (*appsruntime.AppRuntime, error) {
	log := n.log.With(slog.String("op", op))
	log.Info("try start node")

	node, err := n.nodeActions.RunNode(ctx, payload)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	return node, nil
}

func (n *Node) StopNode(ctx context.Context, id int) (*appsruntime.AppRuntime, error) {
	const op = "NODE.StopNode"
	log := n.log.With(slog.String("op", op))
	log.Info("try start node")

	node, err := n.nodeActions.StopNode(ctx, 1)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	return node, nil
}

func (n *Node) SyncAppScripts(ctx context.Context, id int) (*models.Node, error) {
	log := n.log.With(slog.String("op", op))
	log.Info("sync node scripts")

	node, err := n.nodeCRUD.Read(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	scripts, err := n.envService.ParseAppPkgJson(node.Path)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	node.Scripts = scripts.Scripts
	node, err = n.nodeCRUD.Update(ctx, node)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}
	return node, nil
}

func (n *Node) UpdateAppDefaultNodeJsVerion(ctx context.Context, id int, version string, updateNvmrc bool) (string, error) {

	node, err := n.nodeCRUD.InternalGetNodeById(ctx, id)
	if err != nil {
		return "", fmt.Errorf("%s: %w", op, err)
	}

	node.NodeJsVersion = version
	node, err = n.nodeCRUD.Update(ctx, node)
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

func (n *Node) UpdateDefaultRunScript(ctx context.Context, id int, script string) (node *models.Node, err error) {
	const op = "NODE.UpdateDefaultRunScript"
	log := n.log.With(slog.String("op", op), slog.Int("Id", id))
	log.Info("try start node")

	node, err = n.nodeCRUD.InternalGetNodeById(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	node.DefaultScript = script
	node, err = n.nodeCRUD.Update(ctx, node)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}
	return node, nil
}
