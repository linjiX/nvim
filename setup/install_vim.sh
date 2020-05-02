#!/bin/bash

if [ -f ~/.vimrc ]; then
    echo 'Please remove your ~/.vimrc file first'
    exit 1
fi

pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null
set -euo pipefail
set -x

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
# https://github.com/nodesource/distributions#debinstall
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
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
    libjansson-dev

./install_ctags.sh
./install_global.sh
./install_ripgrep.sh

#######################
# Install Vim Plugins #
#######################

vim

popd >/dev/null
