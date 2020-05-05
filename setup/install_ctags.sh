#!/bin/bash

# https://github.com/universal-ctags/ctags

[ -r /etc/lsb-release ] && source /etc/lsb-release
if [ "$DISTRIB_CODENAME" != 'xenial' ]; then
    echo 'Only support ubuntu 16.04'
    exit 1
fi

set -euo pipefail
set -x

###########################
# Install Universal Ctags #
###########################

if ! dpkg -s autoconf git make libjansson-dev 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y \
        autoconf \
        git \
        make \
        libjansson-dev
fi

readonly TMPDIR="$(mktemp -d /tmp/install_ctags.XXXX)"
pushd "$TMPDIR" >/dev/null
git clone --depth=1 https://github.com/universal-ctags/ctags.git
pushd ctags >/dev/null

./autogen.sh
./configure
make -j "$(nproc)"
sudo make install

popd >/dev/null
popd >/dev/null
