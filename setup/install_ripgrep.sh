#!/bin/bash

# https://github.com/BurntSushi/ripgrep/releases

set -e
set -v

###################
# Install Riggrep #
###################

VERSION="11.0.2"
DEBFILE=ripgrep_${VERSION}_amd64.deb

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

TMPDIR="$(mktemp -d /tmp/install_ripgrep.XXXX)"
pushd "$TMPDIR" >/dev/null
wget https://github.com/BurntSushi/ripgrep/releases/download/$VERSION/$DEBFILE

sudo dpkg -i $DEBFILE
