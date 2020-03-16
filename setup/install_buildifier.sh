#!/bin/bash

# https://github.com/bazelbuild/buildtools/tree/master/buildifier

set -e
set -v

VERSION="2.2.1"

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

GOPATH="$(mktemp -d /tmp/install_buildifier.XXXX)"
export GOPATH
export GO111MODULE=on
go get github.com/bazelbuild/buildtools/buildifier@$VERSION
sudo mv "$GOPATH/bin/buildifier" /usr/local/bin
