#!/bin/bash

if [ -f ~/.vimrc ]; then
    echo 'Please remove your ~/.vimrc file first'
    exit
fi

pushd $(dirname ${BASH_SOURCE[0]}) > /dev/null
set -e
set -v

###################
# Install Vim 8.1 #
###################

sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y \
    autoconf \
    vim \
    vim-scripts \
    vim-doc \
    vim-gtk \
    python3-dev \
    silversearcher-ag

./install_ctags.sh
./install_global.sh
./install_ripgrep.sh

#######################
# Install Vim Plugins #
#######################

vim

popd > /dev/null
