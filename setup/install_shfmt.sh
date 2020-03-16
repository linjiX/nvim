#!/bin/bash

# https://github.com/mvdan/sh

set -e
set -v

if ! command -v go 1>/dev/null 2>&1; then
    if ! dpkg -s git software-properties-common 1>/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y \
            software-properties-common \
            git
    fi
    sudo apt-add-repository -y ppa:longsleep/golang-backports
    sudo apt-get update
    sudo apt-get install -y golang-go
fi

GOPATH="$(mktemp -d /tmp/install_shfmt.XXXX)"
export GOPATH
export GO111MODULE=on
go get mvdan.cc/sh/v3/cmd/shfmt
sudo mv "$GOPATH/bin/shfmt" /usr/local/bin
