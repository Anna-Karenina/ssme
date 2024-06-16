package services

import "errors"

var (
	ErrZeroProcess             = errors.New("no pid running")
	ErrZeroRunningProcess      = errors.New("no one node running from desktopapp")
	ErrPkgJsonIsMissing        = errors.New("package.json via address is missing")
	ErrPkgJsonReading          = errors.New("package.json unmarshal error")
	ErrRuningScriptDidNotExist = errors.New("running script did not exist")
	ErrInNodeRuntime           = errors.New("node runtime error")
)
