#!/bin/bash
set -e
apt-get update -qq
apt-get install -y -qq protobuf-compiler
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
export PATH="$PATH:/root/go/bin"
protoc \
  --proto_path=/work/proto-files/proto \
  --go_out=/work/proto-generation/gen \
  --go_opt=paths=source_relative \
  --go-grpc_out=/work/proto-generation/gen \
  --go-grpc_opt=paths=source_relative \
  /work/proto-files/proto/message/v1/message.proto \
  /work/proto-files/proto/notification/v1/notification.proto
cd /work/proto-generation && go mod tidy
