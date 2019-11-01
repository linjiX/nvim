#!/bin/bash

# https://github.com/mvdan/sh

set -e
set -v

if ! command -v go 1>/dev/null 2>&1; then
    sudo apt-add-repository -y ppa:longsleep/golang-backports
    sudo apt-get update
    sudo apt-get install -y golang-go
fi

GOPATH="$(mktemp -d)"
export GOPATH
go get mvdan.cc/sh/cmd/shfmt
sudo mv "$GOPATH/bin/shfmt" /usr/local/bin
