#!/bin/bash

# https://releases.llvm.org/9.0.0/tools/clang/docs/ClangFormat.html
# http://releases.llvm.org/download.html

set -euo pipefail
set -x

########################
# Install clang-format #
########################

if ! dpkg -s software-properties-common wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y \
        software-properties-common \
        wget
fi

sudo apt-add-repository -y 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-9 main'
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y clang-format-9
sudo ln -sf /usr/bin/clang-format-9 /usr/bin/clang-format
