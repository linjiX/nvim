# .vim
My customized vim configuration

## Install Vim 8.1

    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt-get update
    sudo apt-get install vim

## Install dependencies

    sudo apt-get update
    sudo apt-get install -y \
            vim-scripts \
            vim-doc \
            vim-gtk \
            python3-dev \
            silversearcher-ag \
            exuberant-ctags \
            libclang-dev

Install Nodejs and yarn (for COC)

    curl -sL install-node.now.sh/lts | sudo bash
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
    source ~/.bashrc

## Get my Vim configuration
If you have your own .vimrc file in home directory, please remove or rename it to trigger this configuration.

    cd ~
    git clone -depth=1 https://github.com/linjiX/.vim.git

## Get Vim plugin management: vim-plug

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## Install all Vim plugins
May take a long time ...

    vim ~/.vim/vimrc.plug -c PlugInstall -c qa

## Install COC extensions
refer to <https://github.com/neoclide/coc.nvim>

    vim ~/.vim/vimrc.plug -c CocInstall coc-json coc-snippets coc-word coc-pairs -c qa

## Install Language Server
refer to <https://github.com/neoclide/coc.nvim/wiki/Language-servers#supported-features>

For C family language, Language Server "ccls" is the best choice for now

refer to <https://github.com/MaskRay/ccls/wiki/Build>

For Ubuntu 16.04, refer to [INSTALL_CCLS.md](setup/INSTALL_CCLS.md)

## Install latest GNU global (optional)

    cd setup
    ./install_global.sh

## Fonts
Vim may meet some display issues in your machine. The reason is your terminal font doesn't support powerline character.

Here is a recommended font: <https://github.com/crvdgc/Consolas-with-Yahei>

Install and enable it in your terminal.

---
#### Select a colorscheme for yourself, then enjoy your Vim!

---

## How to update

    cd ~/.vim
    git pull
    vim ~/.vim/vimrc.plug
    :PlugUpdate
    :CocUpdate
    :qa



