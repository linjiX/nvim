#!/bin/bash

# https://apt.llvm.org
# https://releases.llvm.org/10.0.0/tools/clang/docs/ClangFormat.html
# http://releases.llvm.org/download.html

set -euo pipefail
set -x

########################
# Install clang-format #
########################

if ! dpkg -s wget software-properties-common apt-transport-https 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y \
        wget \
        software-properties-common \
        apt-transport-https
fi

sudo apt-add-repository -y 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-10 main'
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y clang-format-10
sudo ln -sf /usr/bin/clang-format-10 /usr/bin/clang-format
