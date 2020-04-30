#!/bin/bash

# http://cppcheck.sourceforge.net/
# https://github.com/danmar/cppcheck

set -euo pipefail
set -v

####################
# Install cppcheck #
####################

readonly VERSION="1.90"
readonly TARFILE="$VERSION.tar.gz"
readonly DIR="cppcheck-$VERSION"

if ! dpkg -s cmake make php7.0-xml wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y \
        wget \
        cmake \
        make \
        php7.0-xml
fi

readonly TMPDIR="$(mktemp -d /tmp/install_cppcheck.XXXX)"
pushd "$TMPDIR" >/dev/null
wget -c https://github.com/danmar/cppcheck/archive/$TARFILE
tar -xf $TARFILE
pushd $DIR >/dev/null
mkdir build
pushd build >/dev/null
cmake ..
make -j "$(nproc)"
sudo make install

popd >/dev/null
popd >/dev/null
popd >/dev/null
