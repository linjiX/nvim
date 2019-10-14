#!/bin/bash

# https://github.com/hadolint/hadolint

pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null
set -e
set -v

####################
# Install hadolint #
####################

VERSION=v1.17.2

wget https://github.com/hadolint/hadolint/releases/download/$VERSION/hadolint-Linux-x86_64
chmod +x hadolint-Linux-x86_64
sudo mv hadolint-Linux-x86_64 /usr/bin/hadolint

popd >/dev/null
