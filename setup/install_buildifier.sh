#!/bin/bash

# https://github.com/bazelbuild/buildtools/tree/master/buildifier

[ -r /etc/lsb-release ] && source /etc/lsb-release
if [[ "$DISTRIB_CODENAME" != 'xenial' && "$DISTRIB_CODENAME" != 'focal' ]]; then
    echo 'Only support ubuntu 16.04 and 20.04'
    exit 1
fi

set -euo pipefail
set -x

readonly VERSION="6.0.1"

if ! command -v go &>/dev/null; then
    if ! dpkg -s software-properties-common &>/dev/null; then
        sudo apt-get update
        sudo apt-get install -y software-properties-common
    fi
    sudo apt-add-repository -y ppa:longsleep/golang-backports

    sudo apt-get update
    sudo apt-get install -y golang-go
fi

GOPATH="$(mktemp -d /tmp/install_buildifier.XXXX)"
readonly GOPATH
export GOPATH
go install github.com/bazelbuild/buildtools/buildifier@$VERSION
sudo mv "$GOPATH/bin/buildifier" /usr/local/bin
