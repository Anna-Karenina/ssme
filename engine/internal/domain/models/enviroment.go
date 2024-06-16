package models

import appsruntime "github.com/Anna-Karenina/sme-engine/internal/app/apps_runtime"

type Enviroment struct {
	Mem      string
	Cpu      string
	Quantity int32
}

type ProcessInfo struct {
	Environment *Enviroment
	Nodes       []*appsruntime.AppRuntime
}

type AppPkgJson struct {
	Version string //unused now
	Scripts []string
}

type NodejsVersionsInfo struct {
	Installed []string
	RemoteLts []string
}
