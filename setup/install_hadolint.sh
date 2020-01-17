#!/bin/bash

# https://github.com/hadolint/hadolint

set -e
set -v

####################
# Install hadolint #
####################

VERSION="v1.17.4"
FILE="hadolint-Linux-x86_64"

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

TMPDIR="$(mktemp -d /tmp/install_hadolint.XXXX)"
pushd "$TMPDIR" >/dev/null
wget https://github.com/hadolint/hadolint/releases/download/$VERSION/$FILE
chmod +x $FILE
sudo mv $FILE /usr/local/bin/hadolint

popd >/dev/null
