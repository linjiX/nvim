#!/bin/bash

# http://cppcheck.sourceforge.net/
# https://github.com/danmar/cppcheck

set -e
set -v

####################
# Install cppcheck #
####################

VERSION="1.90"
TARFILE="$VERSION.tar.gz"
DIR="cppcheck-$VERSION"

if ! dpkg -s cmake make php7.0-xml wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y \
        wget \
        cmake \
        make \
        php7.0-xml
fi

TMPDIR="$(mktemp -d /tmp/install_cppcheck.XXXX)"
pushd "$TMPDIR" >/dev/null
wget https://github.com/danmar/cppcheck/archive/$TARFILE
tar -xf $TARFILE
pushd $DIR >/dev/null
mkdir build
pushd build >/dev/null
cmake ..
if [[ -z $DOCKER ]]; then
    make -j
else
    make -j3
fi
sudo make install

popd >/dev/null
popd >/dev/null
popd >/dev/null
