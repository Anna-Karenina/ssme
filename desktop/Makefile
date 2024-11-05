PROJECT_ROOT_DIR=/Users/vladislav.sokolov/develop/github.com/Anna-Karenina/ssme

.PHONY: proto_generate
proto_generate:
	protoc --proto_path=$(PROJECT_ROOT_DIR)/proto $(PROJECT_ROOT_DIR)/proto/*proto   --dart_out=grpc:$(PROJECT_ROOT_DIR)/desktop/lib/pb