#!/bin/bash

if [ -f ~/.vimrc ]; then
    echo 'Please remove your "~/.vimrc" first'
    exit 1
fi

set -euo pipefail
set -x

if [ "$(uname)" == Darwin ]; then
    brew install vim
else
    if ! dpkg -s software-properties-common &>/dev/null; then
        sudo apt-get update
        sudo apt-get install -y software-properties-common
    fi

    sudo apt-add-repository -y ppa:jonathonf/vim
    sudo apt-get update
    sudo apt-get install -y \
        vim \
        vim-scripts \
        vim-doc \
        vim-gtk
fi

ln -s ~/.config/nvim/vimrc ~/.vimrc
