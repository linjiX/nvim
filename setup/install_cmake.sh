#!/bin/bash

# https://github.com/Kitware/CMake

set -e
set -v

VERSION="3.14.0"
TARFILE=v$VERSION.tar.gz
DIR=CMake-$VERSION

wget https://github.com/Kitware/CMake/archive/$TARFILE

tar -xvf $TARFILE > /dev/null
rm $TARFILE
pushd $DIR > /dev/null
./configure
make
sudo make install

popd > /dev/null
