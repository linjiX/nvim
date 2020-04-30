#!/bin/bash

# https://www.gnu.org/software/global/

set -euo pipefail
set -x

######################
# Install GNU Global #
######################

readonly VERSION="6.6.4"
readonly TARFILE=global-$VERSION.tar.gz
readonly DIR=global-$VERSION

if ! dpkg -s autoconf wget make bison flex gperf libtool-bin libncurses5-dev texinfo \
    1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y \
        autoconf \
        wget \
        make \
        bison \
        flex \
        gperf \
        libtool-bin \
        libncurses5-dev \
        texinfo
fi

readonly TMPDIR="$(mktemp -d /tmp/install_global.XXXX)"
pushd "$TMPDIR" >/dev/null
wget -c http://tamacom.com/global/$TARFILE
tar -xf $TARFILE
pushd $DIR >/dev/null

sh reconf.sh
./configure
make -j "$(nproc)"
sudo make install

popd >/dev/null
popd >/dev/null
