#!/bin/bash

readonly VIM_HOME=$HOME/.config/nvim

setup_ubuntu() {
    if ! dpkg -s curl software-properties-common &>/dev/null; then
        sudo apt-get update
        sudo apt-get install -y \
            curl \
            software-properties-common
    fi

    ############################
    # Install NeoVim && Nodejs #
    ############################
    sudo apt-add-repository -y ppa:neovim-ppa/unstable
    # https://github.com/nodesource/distributions#debinstall
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    # sudo apt-get update
    sudo apt-get install -y \
        git \
        neovim \
        nodejs

    #######################
    # Install Vim Plugins #
    #######################
    git clone --depth=1 https://github.com/linjiX/.vim.git "$VIM_HOME"
    nvim

    ########################
    # Install Useful tools #
    ########################
    if [ "$DISTRIB_CODENAME" == 'xenial' ]; then
        sudo apt-get install -y \
            autoconf \
            make \
            wget \
            libjansson-dev

        pushd "$VIM_HOME/setup" >/dev/null
        ./install_ctags.sh
        ./install_global.sh
        ./install_ripgrep.sh
        popd >/dev/null
    else
        sudo apt-get install -y \
            universal-ctags \
            global \
            ripgrep
    fi
}

setup_macos() {
    #######################
    # Install Dependicies #
    #######################
    brew install --with-jansson --HEAD universal-ctags/universal-ctags/universal-ctags
    brew install \
        git \
        node \
        neovim \
        global \
        ripgrep

    #######################
    # Install Vim Plugins #
    #######################
    git clone --depth=1 https://github.com/linjiX/.vim.git "$VIM_HOME"
    nvim
}

if [ "$(uname)" == Darwin ]; then
    if ! command -v brew &>/dev/null; then
        echo 'Install homebrew (https://brew.sh) first'
        exit 1
    fi
else
    [ -r /etc/lsb-release ] && source /etc/lsb-release
    if [[ "$DISTRIB_CODENAME" != 'xenial' && "$DISTRIB_CODENAME" != 'focal' ]]; then
        echo 'Only support ubuntu 16.04 and 20.04'
        exit 1
    fi
fi

if [ -d "$VIM_HOME" ]; then
    echo 'Please remove your "~/.config/nvim" first'
    exit 1
fi

if ! python3 -c "import neovim" &>/dev/null; then
    echo 'Neovim needs python3 and "neovim" package, run "pip3 install neovim" first'
    exit 1
fi

set -euo pipefail
set -x

if [ "$(uname)" == Darwin ]; then
    setup_macos
else
    setup_ubuntu
fi

set +x
echo
echo '###################################'
echo '  "linjiX/.vim" setup successful!  '
echo '###################################'
