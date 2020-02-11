#!/bin/bash

# https://github.com/bazelbuild/bazelisk

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

GOPATH="$(mktemp -d /tmp/install_bazelisk.XXXX)"
export GOPATH
go get github.com/bazelbuild/bazelisk
sudo mv "$GOPATH/bin/bazelisk" /usr/local/bin
