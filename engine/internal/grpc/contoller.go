package grpc_controller

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

type Apps interface {
	CreateApp(ctx context.Context, path string, name string) (node *models.Node, err error)
	ReadApp(ctx context.Context, id int) (node *models.Node, err error)

	ReadAllApps(ctx context.Context) (nodes []*models.Node, err error)

	RunApp(ctx context.Context, payload *appsruntime.RunAppPayload) (node *appsruntime.AppRuntime, err error)
	StopApp(ctx context.Context, in int) (node *appsruntime.AppRuntime, err error)
	SyncAppScripts(ctx context.Context, id int) (*models.Node, error)
	UpdateAppDefaultNodeJsVerion(ctx context.Context, id int, version string, updateNvmrc bool) (string, error)
	UpdateDefaultRunScript(ctx context.Context, id int, script string) (node *models.Node, err error)
}

type Environment interface {
	GetDataAboutProcess() (processInfo *models.ProcessInfo, err error)
	GetNodejsInfo(ctx context.Context) (*models.NodejsVersionsInfo, error)
	DownloadNodeJsVersion(version string, messageCh chan string)
}

type serverAPI struct {
	apiv1.UnimplementedAppsServer
	apiv1.UnimplementedEnvironmentServer
	apps        Apps
	environment Environment
	appsStorage *appsruntime.AppsStorage
}

func Register(gRPCServer *grpc.Server, apps Apps, environment Environment, appsStorage *appsruntime.AppsStorage) {
	sapi := &serverAPI{apps: apps, appsStorage: appsStorage, environment: environment}
	apiv1.RegisterAppsServer(gRPCServer, sapi)
	apiv1.RegisterEnvironmentServer(gRPCServer, sapi)
}

func (s *serverAPI) CreateApp(ctx context.Context, in *apiv1.CreateAppPayload) (*apiv1.App, error) {
	app, err := s.apps.CreateApp(ctx, in.Path, in.Name)
	if err != nil {
		return nil, status.Error(codes.Internal, fmt.Sprint(err))
	}
	return mapAppToApiApp(app), nil
}

func (s *serverAPI) ReadApp(ctx context.Context, in *apiv1.AppIdPayload) (*apiv1.App, error) {
	if in.Id == 0 {
		return nil, status.Error(codes.InvalidArgument, "id should be provided")
	}
	app, err := s.apps.ReadApp(ctx, int(in.Id))
	if err != nil {
		return nil, status.Error(codes.Internal, "failed to get")
	}

	return mapAppToApiApp(app), nil
}

func (s *serverAPI) ReadAllApps(ctx context.Context, ep *apiv1.EmptyParams) (*apiv1.AppList, error) {
	apps, err := s.apps.ReadAllApps(ctx)
	if err != nil {
		return nil, status.Error(codes.Internal, "failed to get")
	}
	fmt.Printf("%v", apps)
	responseApps := make([]*apiv1.App, 0, len(apps))

	for _, node := range apps {
		responseApps = append(responseApps, mapAppToApiApp(node))
	}

	return &apiv1.AppList{Apps: responseApps}, nil
}

func (s *serverAPI) RunApp(ctx context.Context, in *apiv1.RunAppRequest) (*apiv1.AppRunTime, error) {
	version := ""
	if in.Command == "" {
		return nil, status.Error(codes.InvalidArgument, "command should be provided")
	}
	if in.Id == 0 {
		return nil, status.Error(codes.InvalidArgument, "id should be provided")
	}

	if in.NodeVersion == "" {
		app, err := s.apps.ReadApp(ctx, int(in.Id))
		if err != nil {
			fmt.Println("smt goes wrong in ctrl run node func ")
		}
		version = app.NodeJsVersion
	}

	payload := &appsruntime.RunAppPayload{Id: int(in.Id), Command: in.Command, NodeVersion: version}
	n, err := s.apps.RunApp(ctx, payload)
	if err != nil {
		return nil, status.Error(codes.Internal, fmt.Sprint(err))
	}

	return &apiv1.AppRunTime{
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

func (s *serverAPI) StopApp(ctx context.Context, in *apiv1.StopAppRequest) (*apiv1.AppRunTime, error) {
	app, err := s.apps.StopApp(ctx, int(in.Id))
	if err != nil {
		fmt.Println("failed to stop")
		return nil, status.Error(codes.NotFound, "failed to stop")
	}

	return &apiv1.AppRunTime{
		Id:     int32(app.Id),
		Status: app.Status,
		Pid:    int32(app.Pid),
		Cpu:    int32(app.Cpu),
		Mem:    int32(app.Mem),
		Sid:    int32(app.Sid),
		Ports:  app.Ports,
		Branch: app.Branch,
	}, nil
}

func (s *serverAPI) ProcessStream(req *apiv1.DataRequest, stream apiv1.Environment_ProcessStreamServer) error {
	for {
		time.Sleep(5 * time.Second)
		apps := make([]*apiv1.AppRunTime, 0)

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
			n := &apiv1.AppRunTime{
				Id:     int32(node.Id),
				Status: node.Status,
				Pid:    int32(node.Pid),
				Cpu:    int32(node.Cpu),
				Mem:    int32(node.Mem),
				Sid:    int32(node.Sid),
				Ports:  node.Ports,
				Branch: node.Branch,
			}
			apps = append(apps, n)
		}

		resp := &apiv1.ProcessInfo{
			Environment: &apiv1.TotalEnviromentUsage{Cpu: value.Environment.Cpu, Mem: value.Environment.Mem, Quantity: value.Environment.Quantity},
			Apps:        apps,
		}

		stream.Context().Done()
		if err := stream.Send(resp); err != nil {
			return status.Error(codes.Internal, "failed to send message")
		}
	}
}

func (s *serverAPI) SyncAppScripts(ctx context.Context, in *apiv1.AppIdPayload) (*apiv1.App, error) {
	node, err := s.apps.SyncAppScripts(ctx, int(in.Id))
	if err != nil {
		return nil, status.Error(codes.Internal, fmt.Sprint(err))
	}
	return mapAppToApiApp(node), nil
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

	sts, err := s.apps.UpdateAppDefaultNodeJsVerion(ctx, int(in.Id), in.Version, in.UpdateNvmrc)
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

func (s *serverAPI) UpdateDefaultRunScript(ctx context.Context, in *apiv1.UpdateDefaultRunScriptParams) (*apiv1.App, error) {
	app, err := s.apps.UpdateDefaultRunScript(ctx, int(in.Id), in.Script)

	if err != nil {
		return nil, status.Error(codes.NotFound, fmt.Sprint(err))
	}

	return &apiv1.App{
		Id:            int32(app.Id),
		Path:          app.Path,
		Name:          app.Name,
		NodeVersion:   app.NodeJsVersion,
		Scripts:       app.Scripts,
		DefaultScript: app.DefaultScript,
	}, err
}

func mapAppToApiApp(app *models.Node) *apiv1.App {
	return &apiv1.App{
		Id:            int32(app.Id),
		Path:          app.Path,
		Name:          app.Name,
		Scripts:       app.Scripts,
		NodeVersion:   app.NodeJsVersion,
		DefaultScript: app.DefaultScript,
		IsAppValid:    app.IsAppValid,
	}
}
