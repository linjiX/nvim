#!/bin/bash

# https://github.com/hadolint/hadolint

set -e
set -v

####################
# Install hadolint #
####################

VERSION="v1.17.4"
FILE="hadolint-Linux-x86_64"
TARGET="/usr/local/bin/hadolint"

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

sudo wget -c https://github.com/hadolint/hadolint/releases/download/$VERSION/$FILE -O $TARGET
sudo chmod +x $TARGET
