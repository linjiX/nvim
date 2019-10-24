#!/bin/bash

# https://github.com/Kitware/CMake & https://apt.kitware.com/
# http://apt.llvm.org/
# https://github.com/MaskRay/ccls

pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null
set -e
set -v

################
# Install ccls #
################

if [ ! -d 'ccls' ]; then
    # ppa for CMake
    sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main'
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null |
        sudo apt-key add -
    # ppa for LLVM
    sudo apt-add-repository 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-9 main'
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key |
        sudo apt-key add -
    # ppa for gcc
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test

    sudo apt-get update
    sudo apt-get install -y \
        cmake \
        g++-7 \
        llvm-9 libclang-9-dev clang-9 \
        zlib1g-dev libncurses-dev

    # Clone ccls source code
    git clone --depth=1 --recursive https://github.com/MaskRay/ccls
    pushd ccls >/dev/null
else
    pushd ccls >/dev/null
    rm -rf Release/
    git pull
fi

# Compile ccls
export CC=/usr/bin/gcc-7
export CXX=/usr/bin/g++-7

cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=/usr/lib/llvm-9 \
    -DLLVM_INCLUDE_DIR=/usr/lib/llvm-9/include \
    -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-9/

cmake --build Release -j
sudo cmake --build Release --target install

popd >/dev/null
popd >/dev/null
