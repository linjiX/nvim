#!/bin/bash

# http://cppcheck.sourceforge.net/
# https://github.com/danmar/cppcheck

[ -r /etc/lsb-release ] && source /etc/lsb-release
if [ "$DISTRIB_CODENAME" != 'xenial' ]; then
    echo 'Only support ubuntu 16.04'
    exit 1
fi

set -euo pipefail
set -x

####################
# Install cppcheck #
####################

readonly VERSION="1.90"
readonly TARFILE="$VERSION.tar.gz"
readonly DIR="cppcheck-$VERSION"

if ! dpkg -s cmake make wget g++ libpcre3-dev &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y \
        wget \
        cmake \
        make \
        g++ \
        libpcre3-dev
fi

readonly TMPDIR="$(mktemp -d /tmp/install_cppcheck.XXXX)"
pushd "$TMPDIR" >/dev/null
wget -c https://github.com/danmar/cppcheck/archive/$TARFILE
tar -xf $TARFILE
pushd $DIR >/dev/null
mkdir build
pushd build >/dev/null
cmake -DHAVE_RULES=ON ..
make -j "$(nproc)"
sudo make install

popd >/dev/null
popd >/dev/null
popd >/dev/null
