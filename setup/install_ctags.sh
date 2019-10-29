#!/bin/bash

# https://github.com/universal-ctags/ctags

set -e
set -v

###########################
# Install Universal Ctags #
###########################

if ! dpkg -s autoconf git make 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y \
        autoconf \
        git \
        make
fi

TMPDIR="$(mktemp -d)"
pushd "$TMPDIR" >/dev/null
git clone --depth=1 https://github.com/universal-ctags/ctags.git
pushd ctags >/dev/null

./autogen.sh
./configure
make -j
sudo make install

popd >/dev/null
popd >/dev/null
