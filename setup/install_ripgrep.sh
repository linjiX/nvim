#!/bin/bash

# https://github.com/BurntSushi/ripgrep/releases

[ -r /etc/lsb-release ] && source /etc/lsb-release
if [ "$DISTRIB_CODENAME" != 'xenial' ]; then
    echo 'Only support ubuntu 16.04'
    exit 1
fi

set -euo pipefail
set -x

###################
# Install Riggrep #
###################

readonly VERSION="12.0.1"
readonly DEBFILE=ripgrep_${VERSION}_amd64.deb

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

readonly TMPDIR="$(mktemp -d /tmp/install_ripgrep.XXXX)"
pushd "$TMPDIR" >/dev/null
wget -c https://github.com/BurntSushi/ripgrep/releases/download/$VERSION/$DEBFILE

sudo dpkg -i $DEBFILE
