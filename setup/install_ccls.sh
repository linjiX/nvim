#!/bin/bash

# https://github.com/Kitware/CMake & https://apt.kitware.com/
# http://apt.llvm.org/
# https://wiki.ubuntu.com/ToolChain
# https://github.com/MaskRay/ccls

[ -r /etc/lsb-release ] && source /etc/lsb-release
if [ "$DISTRIB_CODENAME" != 'xenial' ]; then
    echo 'Only support ubuntu 16.04'
    exit 1
fi

set -euo pipefail
set -x

################
# Install ccls #
################

readonly VERSION="0.20220729"

if ! dpkg -s software-properties-common wget &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y \
        software-properties-common \
        wget
fi

sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main'
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc | sudo apt-key add -
# ppa for LLVM
sudo apt-add-repository 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-10 main'
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
# ppa for gcc
sudo apt-add-repository -y ppa:ubuntu-toolchain-r/test

sudo apt-get update
sudo apt-get install -y \
    git \
    cmake \
    g++-9 \
    llvm-10 libclang-10-dev clang-10 \
    zlib1g-dev libncurses5-dev

readonly TMPDIR="$(mktemp -d /tmp/install_ccls.XXXX)"
pushd "$TMPDIR" >/dev/null
git clone -b $VERSION --recurse-submodules --depth=1 https://github.com/MaskRay/ccls.git
pushd ccls >/dev/null
git checkout $VERSION # temp code due to ccls has duplicate tags

export CC=/usr/bin/gcc-9
export CXX=/usr/bin/g++-9

cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=/usr/lib/llvm-10 \
    -DLLVM_INCLUDE_DIR=/usr/lib/llvm-10/include \
    -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-10/

cmake --build Release -j
sudo cmake --build Release --target install

popd >/dev/null
popd >/dev/null
