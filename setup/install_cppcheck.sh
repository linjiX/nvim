#!/bin/bash

set -e
set -v

VERSION="1.87"
TARFILE=$VERSION.tar.gz
DIR=cppcheck-$VERSION
sudo apt-get update
sudo apt-get install -y cmake make php7.0-xml

wget https://github.com/danmar/cppcheck/archive/$TARFILE

tar -xvf $TARFILE
rm $TARFILE
pushd $DIR > /dev/null
mkdir build
pushd build > /dev/null
cmake ..
make -j
sudo make install

popd > /dev/null
popd > /dev/null
