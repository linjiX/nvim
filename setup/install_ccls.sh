#!/bin/bash

# https://github.com/MaskRay/ccls
# Read setup/INSTALL_CCLS.md before executing this script!

set -e
set -v

git clone --depth=1 --recursive https://github.com/MaskRay/ccls
pushd ccls > /dev/null

export CC=/usr/bin/gcc-7
export CXX=/usr/bin/g++-7

cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=/usr/lib/llvm-8 \
    -DLLVM_INCLUDE_DIR=/usr/lib/llvm-8/include \
    -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-8/

cmake --build Release -j
sudo cmake --build Release --target install

popd > /dev/null
