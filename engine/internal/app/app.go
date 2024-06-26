package app

import (
	"context"
	"log/slog"

	appsruntime "github.com/Anna-Karenina/sme-engine/internal/app/apps_runtime"
	grpcapp "github.com/Anna-Karenina/sme-engine/internal/app/grpc"
	"github.com/Anna-Karenina/sme-engine/internal/services/apps"
	apps_runtime_service "github.com/Anna-Karenina/sme-engine/internal/services/apps_run_time"
	"github.com/Anna-Karenina/sme-engine/internal/services/environment"
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
	runTimeAppsService := apps_runtime_service.NewAppsRunTimeService(log, appsStorage, storage)

	environmentService := environment.New(log, appsStorage)
	appsService := apps.New(log, storage, runTimeAppsService, environmentService)

	putExistingNodesToStorage(appsService, runTimeAppsService, appsStorage)

	grpcApp := grpcapp.New(log, appsService, environmentService, appsStorage, grpcPort)

	return &App{
		GRPCServer:  grpcApp,
		AppsStorage: appsStorage,
	}
}

func putExistingNodesToStorage(appsService *apps.Apps, runTimeAppsService *apps_runtime_service.AppsRunTimeService, appsStorage *appsruntime.AppsStorage) {
	ctx := context.TODO()
	nodes, _ := appsService.ReadAllApps(ctx)
	for _, node := range nodes {
		app := appsruntime.NewAppRunTime(
			runTimeAppsService, node.Id,
		)
		appsStorage.Create(node.Id, app)
	}
}
