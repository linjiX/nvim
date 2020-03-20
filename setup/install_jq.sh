#!/bin/bash

# https://stedolan.github.io/jq/

set -e
set -v

##############
# Install jq #
##############

VERSION="1.6"
FILE="jq-linux64"

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

TMPDIR="$(mktemp -d /tmp/install_jq.XXXX)"
pushd "$TMPDIR" >/dev/null
wget -c https://github.com/stedolan/jq/releases/download/jq-$VERSION/$FILE
chmod +x $FILE
sudo mv $FILE /usr/local/bin/jq

popd >/dev/null
