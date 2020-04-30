#!/bin/bash

# https://github.com/hadolint/hadolint

set -euo pipefail
set -x

####################
# Install hadolint #
####################

readonly VERSION="v1.17.4"
readonly FILE="hadolint-Linux-x86_64"
readonly TARGET="/usr/local/bin/hadolint"

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

sudo wget -c https://github.com/hadolint/hadolint/releases/download/$VERSION/$FILE -O $TARGET
sudo chmod +x $TARGET
