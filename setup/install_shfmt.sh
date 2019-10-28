#!/bin/bash

# https://github.com/mvdan/sh

set -e
set -v

if ! command -v go 1>/dev/null 2>&1; then
    sudo add-apt-repository -y ppa:longsleep/golang-backports
    sudo apt-get update
    sudo apt-get install -y golang-go
fi

GOPATH="$(mktemp -d)"
export GOPATH
go get mvdan.cc/sh/cmd/shfmt
mkdir -p ~/.local/bin
cp "$GOPATH/bin/shfmt" ~/.local/bin
