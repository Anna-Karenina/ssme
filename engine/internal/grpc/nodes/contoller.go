package nodesgrpc

import (
	"context"
	"fmt"
	"log"
	"slices"
	"time"

	appsruntime "github.com/Anna-Karenina/sme-engine/internal/app/apps_runtime"
	"github.com/Anna-Karenina/sme-engine/internal/domain/models"
	serviceerrors "github.com/Anna-Karenina/sme-engine/internal/services"

	apiv1 "github.com/Anna-Karenina/sme-engine/pkg/gen"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type Nodes interface {
	CreateNode(ctx context.Context, path string, name string) (node *models.Node, err error)
	ReadNode(ctx context.Context, id int) (node *models.Node, err error)

	ReadAllNodes(ctx context.Context) (nodes []*models.Node, err error)

	RunNode(ctx context.Context, payload *appsruntime.RunNodePayload) (node *appsruntime.AppRuntime, err error)
	StopNode(ctx context.Context, in int) (node *appsruntime.AppRuntime, err error)
	UpdateNodeScripts(ctx context.Context, id int) (*models.Node, error)
	UpdateAppDefaultNodeJsVerion(ctx context.Context, id int, version string, updateNvmrc bool) (string, error)
	UpdateDefaultRunScript(ctx context.Context, id int, script string) (node *models.Node, err error)
}

type Environment interface {
	GetDataAboutProcess() (processInfo *models.ProcessInfo, err error)
	GetNodejsInfo(ctx context.Context) (*models.NodejsVersionsInfo, error)
	DownloadNodeJsVersion(version string, messageCh chan string)
}

type serverAPI struct {
	apiv1.UnimplementedNodesServer
	apiv1.UnimplementedEnvironmentServer
	nodes       Nodes
	environment Environment
	appsStorage *appsruntime.AppsStorage
}

func Register(gRPCServer *grpc.Server, nodes Nodes, environment Environment, appsStorage *appsruntime.AppsStorage) {
	sapi := &serverAPI{nodes: nodes, appsStorage: appsStorage, environment: environment}
	apiv1.RegisterNodesServer(gRPCServer, sapi)
	apiv1.RegisterEnvironmentServer(gRPCServer, sapi)
}

func (s *serverAPI) CreateNode(ctx context.Context, in *apiv1.CreateRequest) (*apiv1.Node, error) {
	node, err := s.nodes.CreateNode(ctx, in.Path, in.Name)
	if err != nil {
		return nil, status.Error(codes.Internal, fmt.Sprint(err))
	}
	return mapNodeToApiNode(node), nil
}

func (s *serverAPI) ReadNode(ctx context.Context, in *apiv1.ReadRequest) (*apiv1.Node, error) {
	if in.Id == 0 {
		return nil, status.Error(codes.InvalidArgument, "id should be provided")
	}
	node, err := s.nodes.ReadNode(ctx, int(in.Id))
	if err != nil {
		return nil, status.Error(codes.Internal, "failed to get")
	}

	return mapNodeToApiNode(node), nil
}

func (s *serverAPI) ReadAllNodes(ctx context.Context, ep *apiv1.EmptyParams) (*apiv1.NodeList, error) {
	nodes, err := s.nodes.ReadAllNodes(ctx)
	if err != nil {
		return nil, status.Error(codes.Internal, "failed to get")
	}
	fmt.Printf("%v", nodes)
	responseNodes := make([]*apiv1.Node, 0, len(nodes))

	for _, node := range nodes {
		responseNodes = append(responseNodes, mapNodeToApiNode(node))
	}

	return &apiv1.NodeList{Nodes: responseNodes}, nil
}

func (s *serverAPI) RunNode(ctx context.Context, in *apiv1.RunNodeRequest) (*apiv1.NodeRunTime, error) {
	if in.Command == "" {
		return nil, status.Error(codes.InvalidArgument, "command should be provided")
	}
	if in.Id == 0 {
		return nil, status.Error(codes.InvalidArgument, "id should be provided")
	}
	payload := &appsruntime.RunNodePayload{Id: int(in.Id), Command: in.Command}
	n, err := s.nodes.RunNode(ctx, payload)
	if err != nil {
		return nil, status.Error(codes.Internal, fmt.Sprint(err))
	}

	return &apiv1.NodeRunTime{
		Id:     int32(n.Id),
		Status: n.Status,
		Pid:    int32(n.Pid),
		Cpu:    int32(n.Cpu),
		Mem:    int32(n.Mem),
		Sid:    int32(n.Sid),
		Ports:  n.Ports,
		Branch: n.Branch,
	}, nil
}

func (s *serverAPI) StopNode(ctx context.Context, in *apiv1.StopNodeRequest) (*apiv1.NodeRunTime, error) {
	n, err := s.nodes.StopNode(ctx, int(in.Id))
	if err != nil {
		return nil, status.Error(codes.Internal, "failed to stop")
	}

	return &apiv1.NodeRunTime{
		Id:     int32(n.Id),
		Status: n.Status,
		Pid:    int32(n.Pid),
		Cpu:    int32(n.Cpu),
		Mem:    int32(n.Mem),
		Sid:    int32(n.Sid),
		Ports:  n.Ports,
		Branch: n.Branch,
	}, nil
}

func (s *serverAPI) ProcessStream(req *apiv1.DataRequest, stream apiv1.Environment_ProcessStreamServer) error {
	for {
		time.Sleep(5 * time.Second)
		nodes := make([]*apiv1.NodeRunTime, 0)

		value, err := s.environment.GetDataAboutProcess()
		if err != nil {

			switch err {
			case serviceerrors.ErrZeroProcess:
			case serviceerrors.ErrZeroRunningProcess:
				fmt.Println(err)
				value = &models.ProcessInfo{
					Environment: &models.Enviroment{Mem: "0,0%", Cpu: "0.0%", Quantity: 0},
					Nodes:       []*appsruntime.AppRuntime{},
				}
			default:
				fmt.Println("some error")
				return status.Error(codes.Internal, "failed to get enviroment")
			}

		}

		for _, node := range value.Nodes {
			n := &apiv1.NodeRunTime{
				Id:     int32(node.Id),
				Status: node.Status,
				Pid:    int32(node.Pid),
				Cpu:    int32(node.Cpu),
				Mem:    int32(node.Mem),
				Sid:    int32(node.Sid),
				Ports:  node.Ports,
				Branch: node.Branch,
			}
			nodes = append(nodes, n)
		}

		resp := &apiv1.ProcessInfo{
			Environment: &apiv1.TotalEnviromentUsage{Cpu: value.Environment.Cpu, Mem: value.Environment.Mem, Quantity: value.Environment.Quantity},
			Nodes:       nodes,
		}

		stream.Context().Done()
		if err := stream.Send(resp); err != nil {
			return status.Error(codes.Internal, "failed to send message")
		}
	}
}

func (s *serverAPI) UpdateNodeScripts(ctx context.Context, in *apiv1.ReadRequest) (*apiv1.Node, error) {
	node, err := s.nodes.UpdateNodeScripts(ctx, int(in.Id))
	if err != nil {
		return nil, status.Error(codes.Internal, fmt.Sprint(err))
	}
	return mapNodeToApiNode(node), nil
}

func (s *serverAPI) GetNodejsInfo(ctx context.Context, ep *apiv1.EmptyParams) (*apiv1.NodejsVersionsInfo, error) {
	info, err := s.environment.GetNodejsInfo(ctx)
	if err != nil {
		return nil, status.Error(codes.NotFound, fmt.Sprint(err))
	}

	return &apiv1.NodejsVersionsInfo{Installed: info.Installed, RemoteLts: info.RemoteLts}, nil
}

func (s *serverAPI) UpdateDefaultNodejsVersion(ctx context.Context, in *apiv1.UpdateDefaultNodejsVersionParams) (*apiv1.StatusResponse, error) {
	versions, err := s.environment.GetNodejsInfo(ctx)
	if err != nil || slices.Contains(versions.RemoteLts, in.Version) == false {
		return nil, status.Error(codes.InvalidArgument, "correct nodejs version should be provided")
	}

	sts, err := s.nodes.UpdateAppDefaultNodeJsVerion(ctx, int(in.Id), in.Version, in.UpdateNvmrc)
	if err != nil {
		return nil, status.Error(codes.NotFound, fmt.Sprint(err))
	}

	return &apiv1.StatusResponse{Status: sts}, nil

}

func (s *serverAPI) DownloadNodeJsVersion(in *apiv1.RequestVersion, stream apiv1.Environment_DownloadNodeJsVersionServer) error {

	message := make(chan string)
	defer close(message)
	go s.environment.DownloadNodeJsVersion(in.Version, message)

	for {
		msg := <-message
		resp := apiv1.DownloadStatusResponse{Status: msg}
		if err := stream.Send(&resp); err != nil {
			log.Printf("send error %v", err)
		}
		if msg == "done" {
			return nil
		}
	}

}

func (s *serverAPI) UpdateDefaultRunScript(ctx context.Context, in *apiv1.UpdateDefaultRunScriptParams) (*apiv1.Node, error) {
	node, err := s.nodes.UpdateDefaultRunScript(ctx, int(in.Id), in.Script)

	if err != nil {
		return nil, status.Error(codes.NotFound, fmt.Sprint(err))
	}

	return &apiv1.Node{
		Id:            int32(node.Id),
		Path:          node.Path,
		Name:          node.Name,
		NodeVersion:   node.NodeJsVersion,
		Scripts:       node.Scripts,
		DefaultScript: node.DefaultScript,
	}, err
}

func mapNodeToApiNode(node *models.Node) *apiv1.Node {
	return &apiv1.Node{
		Id:            int32(node.Id),
		Path:          node.Path,
		Name:          node.Name,
		Scripts:       node.Scripts,
		NodeVersion:   node.NodeJsVersion,
		DefaultScript: node.DefaultScript,
	}
}
