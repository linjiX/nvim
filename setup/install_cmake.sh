#!/bin/bash

set -e
set -v

VERSION="3.14.0"
TARFILE=v$VERSION.tar.gz

wget https://github.com/Kitware/CMake/archive/$TARFILE

tar -xvf $TARFILE > /dev/null
rm $TARFILE
pushd CMake-${VERSION} > /dev/null
./configure
make
sudo make install

popd > /dev/null
