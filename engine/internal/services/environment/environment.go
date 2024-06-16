package environment

import (
	"bufio"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"log/slog"
	"os"
	"os/exec"
	"regexp"
	"slices"
	"strings"

	appsruntime "github.com/Anna-Karenina/sme-engine/internal/app/apps_runtime"
	"github.com/Anna-Karenina/sme-engine/internal/domain/models"
	serviceerrors "github.com/Anna-Karenina/sme-engine/internal/services"
	"github.com/shirou/gopsutil/v4/process"
)

const op = "environment.service"
const nodejsLocal = "ls"
const nodejsRemote = "ls-remote --lts --sort=desc"

type Environment struct {
	log            *slog.Logger
	runTimeStorage *appsruntime.AppsStorage
}

func New(log *slog.Logger, runTimeStorage *appsruntime.AppsStorage) *Environment {
	return &Environment{log: log, runTimeStorage: runTimeStorage}
}

func (e *Environment) ParseAppPkgJson(appPath string) (*models.AppPkgJson, error) {
	log := e.log.With(slog.String("op", op), slog.String(".path", appPath))

	log.Info("try to parse pkg.json")

	bytes, err := os.ReadFile(fmt.Sprintf("%s/package.json", appPath))
	if err != nil {
		return nil, serviceerrors.ErrPkgJsonIsMissing
	}
	var pkg map[string]interface{}
	if err = json.Unmarshal(bytes, &pkg); err != nil {
		return nil, serviceerrors.ErrPkgJsonReading
	}

	scripts := make([]string, 0)
	version := fmt.Sprint(pkg["version"])

	for key, field := range pkg["scripts"].(map[string]interface{}) {
		if field == "" {
			continue
		} else {
			scripts = append(scripts, key)
		}
	}
	log.Info("pkg.json parsed success")
	return &models.AppPkgJson{Version: version, Scripts: scripts}, nil
}

func (e *Environment) ParseProjectNodeJsVersionFile(appPath string) (string, error) {
	log := e.log.With(slog.String("op", op), slog.String(".path", appPath))

	log.Info("try to parse .nvmrc or .node-version")

	fileName := ".nvmrc"
	file, err := os.Open(fmt.Sprintf("%s/%s", appPath, fileName))
	defer file.Close()

	if errors.Is(err, os.ErrNotExist) {
		log.Info(".nvmrc did not exist, checking .node-version")
		fileName = ".node-version"
		file, err = os.Open(fmt.Sprintf("%s/%s", appPath, fileName))
		if errors.Is(err, os.ErrNotExist) {
			return "", err
		}
		return "", err
	}

	log.Info(fmt.Sprintf("%s exist", fileName))

	if b, err := io.ReadAll(file); err == nil {
		version := string(b)
		log.With(slog.String(fmt.Sprintf("%s data", fileName), version)).Info("")

		return string(version), nil
	} else {
		return "", err
	}
}

func (e *Environment) GetDataAboutProcess() (processInfo *models.ProcessInfo, err error) {
	const op = "service.enviroment.GetDataAboutProcess"
	e.log.With(slog.String("op", op)).Info("try get info about process")

	runningNodePids, ok := getRunningNodePids(e.runTimeStorage) //Взять все пиды запущенных нод
	if !ok {
		return nil, serviceerrors.ErrZeroProcess
	}
	e.log.With(slog.String("op", op)).Info("getting runningNodePids success")

	nodeProcesses, ok := getProcess(runningNodePids) //Взять все нод процессы
	if !ok {
		return nil, serviceerrors.ErrZeroRunningProcess
	}
	e.log.With(slog.String("op", op)).Info("getting nodeProcesses success")

	nodesResources := calcNodesResources(nodeProcesses, e.runTimeStorage) //Посчитать ресуры конкретных процессов
	e.log.With(slog.String("op", op)).Info("getting nodesResources success")

	evnResources := calculateEnviromentResources(nodeProcesses) //Посчитать толотал ресурсы
	e.log.With(slog.String("op", op)).Info("getting evnResources success")

	return &models.ProcessInfo{
		Environment: evnResources,
		Nodes:       nodesResources,
	}, nil
}

func (e *Environment) GetNodejsInfo(ctx context.Context) (*models.NodejsVersionsInfo, error) {
	const op = "service.enviroment.GetNVMInfo"

	return &models.NodejsVersionsInfo{
		Installed: getInstalledNodejs(nodejsLocal),
		RemoteLts: getInstalledNodejs(nodejsRemote)}, nil
}

func getInstalledNodejs(from string) []string {

	versions := make([]string, 0)
	command := fmt.Sprintf("fnm %s", from)
	parts := strings.Split(command, " ")
	cmd := exec.Command(parts[0], parts[1:]...)
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		return versions
	}
	scanner := bufio.NewScanner(stdout)
	err = cmd.Start()
	if err != nil {
		return versions
	}
	for scanner.Scan() {
		versions = append(versions, scanner.Text())
	}

	re := regexp.MustCompile(`v(.*)`)
	tempVersion := make([]string, 0)
	for _, line := range versions {
		match := re.FindStringSubmatch(line)
		if len(match) > 1 {
			tempVersion = append(tempVersion, strings.Split(match[0], " ")[0])
		}
	}

	versions = tempVersion

	return versions
}

func stripChars(str, chr string) string {
	return strings.Map(func(r rune) rune {
		if strings.IndexRune(chr, r) < 0 {
			return r
		}
		return -1
	}, str)
}

func getRunningNodePids(storage *appsruntime.AppsStorage) ([]int32, bool) {
	runningPids := make([]int32, 0)
	for _, app := range storage.Apps {
		runningPids = append(runningPids, int32(app.Pid))
	}
	return runningPids, len(runningPids) > 0
}

func getProcess(runningNodePids []int32) ([]*process.Process, bool) {
	nodeProcesses := make([]*process.Process, 0)
	processes, _ := process.Processes()
	for _, p := range processes {
		name, _ := p.Name()
		c := strings.Contains(name, "node") && slices.Contains(runningNodePids, p.Pid)
		if c {
			nodeProcesses = append(nodeProcesses, p)
		}
	}
	return nodeProcesses, len(nodeProcesses) > 0
}

func calculateEnviromentResources(nodeProcesses []*process.Process) *models.Enviroment {
	totalMemoryUsage := float32(0.0)
	totalCPUUsage := 0.0
	nodeProcessesQty := 0

	for _, p := range nodeProcesses {
		memInfo, _ := p.MemoryPercent()
		cpuInfo, _ := p.CPUPercent()
		nodeProcessesQty++
		totalMemoryUsage += memInfo
		totalCPUUsage += cpuInfo
	}

	return &models.Enviroment{
		Mem:      fmt.Sprintf("%f%%", totalMemoryUsage),
		Cpu:      fmt.Sprintf("%f%%", totalCPUUsage),
		Quantity: int32(nodeProcessesQty),
	}
}

func calcNodesResources(process []*process.Process, storage *appsruntime.AppsStorage) []*appsruntime.AppRuntime {
	fmt.Printf("storage: %v \nproc: %+v\n", &storage.Apps, process)

	apps := make([]*appsruntime.AppRuntime, 0)

	for _, app := range process {
		slog.With(slog.Any("app", app))

		var findedApp *appsruntime.AppRuntime
		var findedAppId int

		for id, sapp := range storage.Apps {
			fmt.Printf("storage app pid: %d\nprocess pid: %d\n", sapp.Pid, app.Pid)
			if sapp.Pid == int(app.Pid) {
				findedApp = sapp
				findedAppId = id
			}
		}

		ports := getPortsByPid(findedApp.Pid)
		memInfo, _ := app.MemoryPercent()
		cpuInfo, _ := app.CPUPercent()

		a := &appsruntime.AppRuntime{
			Id:      findedApp.Id,
			Status:  findedApp.Status,
			Pid:     findedApp.Pid,
			Cpu:     float32(cpuInfo),
			Mem:     memInfo,
			Sid:     findedApp.Sid,
			Ports:   ports,
			Branch:  findedApp.Branch,
			Actions: findedApp.Actions,
		}
		storage.Apps[findedAppId] = a
		apps = append(apps, a)
	}
	return apps
}

func getPortsByPid(pid int) []int32 {
	//Todo write some result
	ports := make([]int32, 0)
	return ports
}
