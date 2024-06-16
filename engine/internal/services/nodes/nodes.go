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

	pkgInfo, err := n.envService.ParseAppPkgJson(path)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	defaultNodeJsversion, err := n.envService.ParseProjectNodeJsVersionFile(path)
	if err != nil {
		defaultNodeJsversion = "v20.14.0"
	}

	node.NodeJsVersion = defaultNodeJsversion
	node.Scripts = pkgInfo.Scripts

	node, err = n.nodeCRUD.Update(ctx, node)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
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

func (n *Node) UpdateNodeScripts(ctx context.Context, id int) (*models.Node, error) {
	log := n.log.With(slog.String("op", op))
	log.Info("update node scripts")

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
