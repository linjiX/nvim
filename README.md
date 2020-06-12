# nvim

![preview image](preview.png)

## Setup

Support OS:

-   Ubuntu 16.04
-   Ubuntu 20.04
-   MacOS

```bash
# Python3 environment and 'neovim' package is needed
pip3 install neovim

# One line setup script
curl -sS https://raw.githubusercontent.com/linjiX/nvim/master/setup/setup.sh | bash
```

It may take a long time, make sure your network is unblocked and be patient.

## Vim8 Support (Optional)

This neovim configuration also supports Vim8

```bash
# Install Vim8 & Link Vim8's configuration to neovim
~/.config/nvim/setup/vim8.sh
```

## Language Support (Optional)

The auto format and static check for different language needs external tools  
Here is how to install them:

-   [Ubuntu 16.04](setup/README_xenial.md)
-   [Ubuntu 20.04](setup/README_focal.md)
-   [MacOS](setup/README_macos.md)

## Fonts

Vim may meet some display issues in your machine.  
The reason is your terminal font doesn't support powerline or nerd-fonts.  
Here is a recommended font: <https://github.com/linjiX/Consolas-with-Yahei>

```bash
# For Ubuntu
mkdir -p ~/.local/share/fonts
git clone --depth=1 https://github.com/linjiX/Consolas-with-Yahei.git
cp Consolas-with-Yahei/ttf/* ~/.local/share/fonts/
```

Then enable it in your terminal.

---

#### Select a colorscheme for yourself, then enjoy your vim!

---

## How to update

```bash
cd ~/.config/nvim
git pull
nvim -c PlugUpdate -c quitall
```
