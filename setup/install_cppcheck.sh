#!/bin/bash

# http://cppcheck.sourceforge.net/

pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null
set -e
set -v

####################
# Install cppcheck #
####################

VERSION="1.89"
TARFILE=$VERSION.tar.gz
DIR=cppcheck-$VERSION

if [ ! -d $DIR ]; then
    sudo apt-get update
    sudo apt-get install -y \
        cmake \
        make \
        php7.0-xml

    wget https://github.com/danmar/cppcheck/archive/$TARFILE
    tar -xvf $TARFILE
    rm $TARFILE
fi

pushd $DIR >/dev/null
mkdir -p build
pushd build >/dev/null
cmake ..
make -j
sudo make install

popd >/dev/null
popd >/dev/null
popd >/dev/null
