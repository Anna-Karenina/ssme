package appsruntime

//AppStatuses : checking, running, stopped, pause, error

import (
	"context"
)

type AppRuntimeActions interface {
	RunApp(ctx context.Context, payload *RunAppPayload) (*AppRuntime, error)
}

type RunAppPayload struct {
	Id          int
	Command     string
	NodeVersion string
}

type AppRuntime struct {
	Id      int
	Status  string
	Pid     int
	Cpu     float32
	Mem     float32
	Sid     int
	Ports   []int32
	Branch  string
	Scripts []string
	Actions AppRuntimeActions
}

func NewAppRunTime(actions AppRuntimeActions, id int) *AppRuntime {
	return &AppRuntime{
		Actions: actions,
		Id:      id,
		Status:  "checking",
	}
}
