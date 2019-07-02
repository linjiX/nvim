#!/bin/bash

# https://github.com/universal-ctags/ctags

set -e
set -v

git clone --depth=1 https://github.com/universal-ctags/ctags.git
pushd ctags > /dev/null

./autogen.sh
./configure
make
sudo make install

popd > /dev/null
