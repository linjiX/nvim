# How to install ccls in Ubuntu 16.04

## cd to ~/.vim/setup

    cd ~/.vim/setup

## Install dependencies

    sudo apt-get update
    sudo apt-get install -y \
            zlib1g-dev \
            libncurses-dev

## Install Cmake (3.8 or higher)

    sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main'
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y cmake

## Install LLVM-9

    sudo apt-add-repository 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-9 main'
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -

    sudo apt-get update
    sudo apt-get install -y llvm-9 libclang-9-dev clang-9

## Install g++-7
refer to <https://gist.github.com/jlblancoc/99521194aba975286c80f93e47966dc5>

    sudo add-apt-repository ppa:ubuntu-toolchain-r/test
    sudo apt-get update
    sudo apt-get install -y g++-7
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 \
                             --slave /usr/bin/g++ g++ /usr/bin/g++-7

    sudo update-alternatives --config gcc
    # Select gcc-7 as default gcc

## Install ccls

    ./install_ccls.sh

    sudo update-alternatives --config gcc
    # Make the default gcc back to gcc-5
