#!/bin/bash

# https://github.com/Kitware/CMake & https://apt.kitware.com/
# http://apt.llvm.org/
# https://github.com/MaskRay/ccls

set -e
set -v

################
# Install ccls #
################

VERSION="0.20190823.4"

if ! dpkg -s software-properties-common wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y \
        software-properties-common \
        wget
fi

sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main'
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc | sudo apt-key add -
# ppa for LLVM
sudo apt-add-repository 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-9 main'
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
# ppa for gcc
sudo apt-add-repository -y ppa:ubuntu-toolchain-r/test

sudo apt-get update
sudo apt-get install -y \
    git \
    cmake \
    g++-7 \
    llvm-9 libclang-9-dev clang-9 \
    zlib1g-dev libncurses5-dev

TMPDIR="$(mktemp -d)"
pushd "$TMPDIR" >/dev/null
git clone -b $VERSION --recurse-submodules --depth=1 https://github.com/MaskRay/ccls.git
pushd ccls >/dev/null
git checkout $VERSION # temp code due to ccls has duplicate tags

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
