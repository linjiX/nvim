#!/bin/bash

# https://github.com/hadolint/hadolint

set -euo pipefail
set -x

####################
# Install hadolint #
####################

readonly VERSION="v1.17.6"
readonly FILE="hadolint-Linux-x86_64"
readonly TARGET="/usr/local/bin/hadolint"

if ! dpkg -s wget &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

sudo wget https://github.com/hadolint/hadolint/releases/download/$VERSION/$FILE -O $TARGET
sudo chmod +x $TARGET
