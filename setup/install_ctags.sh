#!/bin/bash

# https://github.com/universal-ctags/ctags

set -e
set -v

pushd $(dirname ${BASH_SOURCE[0]}) > /dev/null
if [ ! -d 'ctags' ]; then
    git clone --depth=1 https://github.com/universal-ctags/ctags.git
    pushd ctags > /dev/null
else
    pushd ctags > /dev/null
    git pull
fi

./autogen.sh
./configure
make
sudo make install

popd > /dev/null
popd > /dev/null
