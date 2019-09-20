#!/bin/bash

# https://github.com/universal-ctags/ctags

pushd $(dirname ${BASH_SOURCE[0]}) > /dev/null
set -e
set -v

###########################
# Install Universal Ctags #
###########################

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
