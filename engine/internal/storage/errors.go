package storage

import "errors"

var (
	ErrUnknow         = errors.New("Unknown error")
	ErrNodeNotFound   = errors.New("node not found")
	ErrWrongRowParams = errors.New("row is not fit")
)
