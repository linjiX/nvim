#!/bin/bash

# https://github.com/hadolint/hadolint

set -e
set -v

####################
# Install hadolint #
####################

VERSION=v1.17.2

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

TMPDIR="$(mktemp -d)"
pushd "$TMPDIR" >/dev/null
wget https://github.com/hadolint/hadolint/releases/download/$VERSION/hadolint-Linux-x86_64
chmod +x hadolint-Linux-x86_64
mv hadolint-Linux-x86_64 ~/.local/bin/hadolint

popd >/dev/null
