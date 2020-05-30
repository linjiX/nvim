#!/bin/bash

# https://stedolan.github.io/jq/

[ -r /etc/lsb-release ] && source /etc/lsb-release
if [ "$DISTRIB_CODENAME" != 'xenial' ]; then
    echo 'Only support ubuntu 16.04'
    exit 1
fi

set -euo pipefail
set -x

##############
# Install jq #
##############

readonly VERSION="1.6"
readonly FILE="jq-linux64"
readonly TARGET="/usr/local/bin/jq"

if ! dpkg -s wget &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

sudo wget -c https://github.com/stedolan/jq/releases/download/jq-$VERSION/$FILE -O $TARGET
sudo chmod +x $TARGET
