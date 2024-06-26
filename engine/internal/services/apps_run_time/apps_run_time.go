package appsruntimeservice

import (
	"bufio"
	"context"
	"fmt"
	"log/slog"
	"math/rand/v2"
	"os"
	"os/exec"
	"slices"
	"strings"
	"syscall"

	serviceerrors "github.com/Anna-Karenina/sme-engine/internal/services"

	appsruntime "github.com/Anna-Karenina/sme-engine/internal/app/apps_runtime"
	"github.com/Anna-Karenina/sme-engine/internal/domain/models"
)

const op = "service.app_run_time"

type Repository interface {
	InternalGetNodeById(cxt context.Context, id int) (*models.Node, error)
}

type AppsRunTimeService struct {
	log            *slog.Logger
	runTimeStorage *appsruntime.AppsStorage
	repository     Repository
}

func NewAppsRunTimeService(
	log *slog.Logger,
	runTimeStorage *appsruntime.AppsStorage, repository Repository) *AppsRunTimeService {
	return &AppsRunTimeService{log: log, runTimeStorage: runTimeStorage, repository: repository}
}

func (a *AppsRunTimeService) StopNode(ctx context.Context, id int) (*appsruntime.AppRuntime, error) {
	log := a.log.With(slog.String("op", op), slog.Int(".id", id))

	node, err := a.repository.InternalGetNodeById(ctx, id)
	if err != nil {
		log.Info("some err here1: %v", err)
	}

	pid := a.runTimeStorage.Apps[id].Pid
	log.Info(fmt.Sprint(pid))
	proc, err := os.FindProcess(pid)
	if err != nil {
		log.Info("cmd.Process.Stop failed: ", err)
	}

	proc.Signal(syscall.SIGTERM)

	return &appsruntime.AppRuntime{
		Id:     id,
		Status: "stopped",
		Pid:    0,
		Cpu:    0,
		Mem:    0,
		Sid:    0,
		Ports:  make([]int32, 0),
		Branch: getGitBranch(node.Path),
	}, nil
}

func (a *AppsRunTimeService) RunNode(ctx context.Context, payload *appsruntime.RunNodePayload) (*appsruntime.AppRuntime, error) {

	log := a.log.With(slog.String("op", op), slog.String("command:", payload.Command))

	log.Info("try bootstrap node")
	node, err := a.repository.InternalGetNodeById(ctx, payload.Id)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	if !slices.Contains(node.Scripts, payload.Command) {
		return nil, fmt.Errorf("%s: %w", op, serviceerrors.ErrRuningScriptDidNotExist)
	}

	command := fmt.Sprintf("fnm exec --using=%s npm run --prefix %s %s", payload.NodeVersion, node.Path, payload.Command)
	parts := strings.Split(command, " ")

	l, err := os.Create(fmt.Sprintf("%s.log", node.Name)) //rewrite
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, serviceerrors.ErrInNodeRuntime)

	}
	defer l.Close()
	cmd := exec.Command(parts[0], parts[1:]...)

	cmd.Stdout = l
	cmd.Stderr = l

	err = cmd.Start()

	branch := getGitBranch(node.Path)

	go func() {
		err = cmd.Wait()
		fmt.Printf("Command finished with error: %v", err)
	}()

	app := &appsruntime.AppRuntime{
		Pid:    cmd.Process.Pid,
		Sid:    rand.IntN(99999) + 10,
		Status: "running",
		Id:     node.Id,
		Branch: branch,
	}

	a.runTimeStorage.Apps[payload.Id] = app

	return app, nil
}

func getGitBranch(path string) string {
	branch := "unknown"
	command := fmt.Sprintf("git -C %s rev-parse --abbrev-ref HEAD", path)
	parts := strings.Split(command, " ")
	cmd := exec.Command(parts[0], parts[1:]...)

	stdout, err := cmd.StdoutPipe()
	if err != nil {
		return branch
	}
	scanner := bufio.NewScanner(stdout)
	err = cmd.Start()
	if err != nil {
		return branch
	}
	for scanner.Scan() {
		branch = scanner.Text()
	}
	return branch
}
