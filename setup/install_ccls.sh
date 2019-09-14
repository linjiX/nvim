#!/bin/bash

# https://github.com/Kitware/CMake & https://apt.kitware.com/
# http://apt.llvm.org/
# https://github.com/MaskRay/ccls

set -e
set -v

pushd $(dirname ${BASH_SOURCE[0]}) > /dev/null

if [ ! -d 'ccls' ]; then
    # ppa for CMake
    sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main'
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | \
        sudo apt-key add -
    # ppa for LLVM
    sudo apt-add-repository 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main'
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | \
        sudo apt-key add -
    # ppa for gcc
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test

    sudo apt-get update

    sudo apt-get install -y \
        cmake \
        g++-7 \
        llvm-8 libclang-8-dev clang-8 \
        zlib1g-dev libncurses-dev

    # Clone ccls source code
    git clone --depth=1 --recursive https://github.com/MaskRay/ccls
    pushd ccls > /dev/null
else
    pushd ccls > /dev/null
    git pull
fi

# Compile ccls
export CC=/usr/bin/gcc-7
export CXX=/usr/bin/g++-7

cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=/usr/lib/llvm-8 \
    -DLLVM_INCLUDE_DIR=/usr/lib/llvm-8/include \
    -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-8/

cmake --build Release -j
sudo cmake --build Release --target install

popd > /dev/null
popd > /dev/null
