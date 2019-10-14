#!/bin/bash

# https://www.gnu.org/software/global/

pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null
set -e
set -v

######################
# Install GNU Global #
######################

VERSION="6.6.3"
TARFILE=global-$VERSION.tar.gz
DIR=global-$VERSION

if [ ! -d $DIR ]; then
    sudo apt-get update
    sudo apt-get install -y \
        gperf \
        bison \
        flex \
        libtool-bin \
        libncurses-dev \
        texinfo

    wget http://tamacom.com/global/$TARFILE
    tar -xvf $TARFILE >/dev/null
    rm $TARFILE
fi

pushd $DIR >/dev/null
sh reconf.sh
./configure
make -j
sudo make install

popd >/dev/null
popd >/dev/null
