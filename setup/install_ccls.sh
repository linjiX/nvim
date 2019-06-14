#!/bin/bash

# Read setup/INSTALL_CCLS.md before executing this script!

set -e
set -v

git clone --depth=1 --recursive https://github.com/MaskRay/ccls
pushd ccls > /dev/null

cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=/usr/lib/llvm-7 \
    -DLLVM_INCLUDE_DIR=/usr/lib/llvm-7/include \
    -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-7/

cmake --build Release
sudo cmake --build Release --target install

popd > /dev/null
