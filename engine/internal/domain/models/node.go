package models

import (
	"encoding/json"
	"errors"
	"fmt"
)

type Scripts []string

func (cmd *Scripts) Scan(src interface{}) error {
	switch t := src.(type) {
	case nil:
		return json.Unmarshal([]byte(`[]`), &cmd)
	case string:
		raw := []byte(fmt.Sprint(src))
		return json.Unmarshal(raw, &cmd)
	default:
		return errors.New(fmt.Sprintf("Invalid type %v", t))
	}
}

type Node struct {
	Path          string  `db:"path"`
	Id            int     `db:"id"`
	Name          string  `db:"name"`
	Scripts       Scripts `db:"cmds" json:"scripts"`
	NodeJsVersion string  `db:"node_version" json:"nodjs_version"`
}
