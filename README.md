# .vim
My customized vim configuration

## Install Vim 8.1

    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt-get update
    sudo apt-get install vim

## Get Vim plugin management: vim-plug

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## Install dependencies

    sudo apt-get update
    sudo apt-get install -y \
            vim-scripts \
            vim-doc \
            vim-gtk \
            cmake \
            global \
            python3-dev \
            silversearcher-ag \
            build-essential \
            exuberant-ctags \
            libclang-dev

## Get my Vim configuration
If you have your own .vimrc file in home directory,
please remove or rename it to trigger this configuration.

    cd ~
    git clone https://github.com/linjiX/.vim.git


## Install all Vim plugins
May take a long time ...

    vim ~/.vim/vimrc.plug -c PlugInstall -c :qa


## Install YouCompleteMe (optional)
refer to <https://github.com/Valloric/YouCompleteMe>

    cd ~/.vim/plug/YouCompleteMe
    python3 install.py --clang-completer

## Fonts
Vim may meet some display issues in your machine.
The reason is your terminal font doesn't support powerline character.

Here is a recommended font:
<https://github.com/crvdgc/Consolas-with-Yahei>

Install and enable it in your terminal.

#### Select a colorscheme for yourself, Then enjoy your Vim!




