#!/bin/bash

# https://www.gnu.org/software/global/

set -e
set -v

VERSION="6.6.3"
TARFILE=global-$VERSION.tar.gz
DIR=global-$VERSION

sudo apt-get update
sudo apt-get install -y \
    autoconf \
    gperf \
    bison \
    flex \
    libtool-bin \
    libncurses-dev \
    texinfo

wget http://tamacom.com/global/$TARFILE

tar -xvf $TARFILE > /dev/null
rm $TARFILE
pushd $DIR > /dev/null
sh reconf.sh
./configure
make -j
sudo make install

popd > /dev/null
