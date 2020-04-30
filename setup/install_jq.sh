#!/bin/bash

# https://stedolan.github.io/jq/

set -euo pipefail
set -v

##############
# Install jq #
##############

readonly VERSION="1.6"
readonly FILE="jq-linux64"
readonly TARGET="/usr/local/bin/jq"

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

sudo wget -c https://github.com/stedolan/jq/releases/download/jq-$VERSION/$FILE -O $TARGET
sudo chmod +x $TARGET
