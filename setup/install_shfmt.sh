#!/bin/bash

# https://github.com/mvdan/sh

[ -r /etc/lsb-release ] && source /etc/lsb-release
if [[ "$DISTRIB_CODENAME" != 'xenial' && "$DISTRIB_CODENAME" != 'focal' ]]; then
    echo 'Only support ubuntu 16.04 and 20.04'
    exit 1
fi

set -euo pipefail
set -x

if ! command -v go &>/dev/null; then
    if ! dpkg -s git software-properties-common &>/dev/null; then
        sudo apt-get update
        sudo apt-get install -y \
            software-properties-common \
            git
    fi
    sudo apt-add-repository -y ppa:longsleep/golang-backports

    sudo apt-get update
    sudo apt-get install -y golang-go
fi

readonly GOPATH="$(mktemp -d /tmp/install_shfmt.XXXX)"
export GOPATH
go install mvdan.cc/sh/v3/cmd/shfmt@latest
sudo mv "$GOPATH/bin/shfmt" /usr/local/bin
