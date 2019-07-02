#!/bin/bash

# https://www.gnu.org/software/global/

set -e
set -v

VERSION="6.6.3"
TARFILE=global-$VERSION.tar.gz
DIR=global-$VERSION

wget http://tamacom.com/global/$TARFILE

tar -xvf $TARFILE > /dev/null
rm $TARFILE
pushd $DIR > /dev/null
./configure
make -j
sudo make install

popd > /dev/null
