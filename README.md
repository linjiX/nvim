# .vim

![](preview.png)

## Clone Vim configuration

    git clone --depth=1 https://github.com/linjiX/.vim.git ~/.vim

## Installation

**Install nodejs:**

    curl -sL install-node.now.sh/lts | sudo bash

**Run vim installation scripts (for ubuntu 16.04):**

    ~/.vim/setup/install_vim.sh

It will take a long time, make sure your network is unblocked and be patient.

## Fonts

Vim may meet some display issues in your machine.  
The reason is your terminal font doesn't support powerline or nerd-fonts.  
Here is a recommended font: <https://github.com/linjiX/Consolas-with-Yahei>  

    mkdir -p ~/.local/share/fonts
    git clone --depth=1 https://github.com/linjiX/Consolas-with-Yahei.git
    cp Consolas-with-Yahei/ttf/* ~/.local/share/fonts/

Then enable it in your terminal.

---

#### Select a colorscheme for yourself, then enjoy your Vim!

---

## How to update

    cd ~/.vim
    git pull
    vim ~/.vim/vimrc.plug
    :PlugUpdate
    :CocUpdateSync
    :qa
