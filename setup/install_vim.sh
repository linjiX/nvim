#!/bin/bash

if [ -f ~/.vimrc ]; then
    echo 'Please remove your ~/.vimrc file first'
    exit
fi

pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null
set -e
set -v

if ! dpkg -s software-properties-common curl 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y \
        software-properties-common \
        curl
fi

#######################################
# Install Vim 8.1 && NeoVim && Nodejs #
#######################################

sudo apt-add-repository -y ppa:jonathonf/vim
sudo apt-add-repository -y ppa:neovim-ppa/unstable
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
# sudo apt-get update
sudo apt-get install -y \
    autoconf \
    make \
    wget \
    vim \
    vim-scripts \
    vim-doc \
    vim-gtk \
    neovim \
    nodejs \
    python3-dev \
    openjdk-8-jdk

./install_ctags.sh
./install_global.sh
./install_ripgrep.sh

#######################
# Install Vim Plugins #
#######################

vim

popd >/dev/null
