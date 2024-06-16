package app

import (
	"context"
	"log/slog"

	appsruntime "github.com/Anna-Karenina/sme-engine/internal/app/apps_runtime"
	grpcapp "github.com/Anna-Karenina/sme-engine/internal/app/grpc"
	appsruntimeservice "github.com/Anna-Karenina/sme-engine/internal/services/apps_run_time"
	"github.com/Anna-Karenina/sme-engine/internal/services/environment"
	"github.com/Anna-Karenina/sme-engine/internal/services/nodes"
	"github.com/Anna-Karenina/sme-engine/internal/storage/sqlite"
)

type App struct {
	GRPCServer  *grpcapp.App
	AppsStorage *appsruntime.AppsStorage
}

func New(
	log *slog.Logger,
	grpcPort int,
	storagePath string,
) *App {
	storage, err := sqlite.New(log, storagePath)
	if err != nil {
		panic(err)
	}

	appsStorage := appsruntime.NewAppsStorage()
	runTimeAppsService := appsruntimeservice.NewAppsRunTimeService(log, appsStorage, storage)

	environmentService := environment.New(log, appsStorage)
	nodesService := nodes.New(log, storage, runTimeAppsService, environmentService)

	putExistingNodesToStorage(nodesService, runTimeAppsService, appsStorage)

	grpcApp := grpcapp.New(log, nodesService, environmentService, appsStorage, grpcPort)

	return &App{
		GRPCServer:  grpcApp,
		AppsStorage: appsStorage,
	}
}

func putExistingNodesToStorage(nodesService *nodes.Node, runTimeAppsService *appsruntimeservice.AppsRunTimeService, appsStorage *appsruntime.AppsStorage) {
	ctx := context.TODO()
	nodes, _ := nodesService.ReadAllNodes(ctx)
	for _, node := range nodes {
		app := appsruntime.NewAppRunTime(
			runTimeAppsService, node.Id,
		)
		appsStorage.Create(node.Id, app)
	}
}
