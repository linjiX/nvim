#!/bin/bash

# https://github.com/bazelbuild/buildtools/tree/master/buildifier

[ -r /etc/lsb-release ] && source /etc/lsb-release
if [[ "$DISTRIB_CODENAME" != 'xenial' && "$DISTRIB_CODENAME" != 'focal' ]]; then
    echo 'Only support ubuntu 16.04 and 20.04'
    exit 1
fi

set -euo pipefail
set -x

readonly VERSION="3.5.0"

if ! command -v go &>/dev/null; then
    if [ "$DISTRIB_CODENAME" == 'xenial' ]; then
        if ! dpkg -s software-properties-common &>/dev/null; then
            sudo apt-get update
            sudo apt-get install -y software-properties-common
        fi
        sudo apt-add-repository -y ppa:longsleep/golang-backports
    fi
    sudo apt-get update
    sudo apt-get install -y golang-go
fi

readonly GOPATH="$(mktemp -d /tmp/install_buildifier.XXXX)"
export GOPATH
export GO111MODULE=on
go get github.com/bazelbuild/buildtools/buildifier@$VERSION
sudo mv "$GOPATH/bin/buildifier" /usr/local/bin
