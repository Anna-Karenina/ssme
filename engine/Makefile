PROJECT_NAME=ssme-engine

LOCAL_BIN=$(CURDIR)/bin

.PHONY: run
run: 
	go run cmd/engine/main.go --config=./config/config_local.yaml

.PHONY: lint
lint:
	golangci-lint run 

.PHONY: build
build:
	CGO_ENABLED=0 go build -v -o $(LOCAL_BIN)/$(PROJECT_NAME) ./cmd/engine/main.go


.PHONY: generate
generate:
	protoc -I ~/develop/self/ssme/proto  nodes.proto --go_out=./pkg/gen/ --go_opt=paths=source_relative --go-grpc_out=./pkg/gen/ --go-grpc_opt=paths=source_relative

.PHONY: create_db
create_db:
	sqlite3 storage/engine.db
