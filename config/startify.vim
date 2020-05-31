"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    https://github.com/linjiX/.vim                           "
"     _  _          _  _ __  __    __        _                "
"    | |(_) _ __   (_)(_)\ \/ /   / /__   __(_) _ __ ___      "
"    | || || '_ \  | || | \  /   / / \ \ / /| || '_ ` _ \     "
"    | || || | | | | || | /  \  / /_  \ V / | || | | | | |    "
"    |_||_||_| |_|_/ ||_|/_/\_\/_/(_)  \_/  |_||_| |_| |_|    "
"                |__/                                         "
"                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:startify_change_to_vcs_root = 1
let g:startify_bookmarks = [
            \   {'v': '~/.config/nvim/init.vim'},
            \   {'p': '~/.config/nvim/plugs.vim'},
            \   {'c': '~/.config/nvim/coc-settings.json'},
            \   {'s': '~/.config/nvim/plug/coc.nvim/data/schema.json'},
            \   {'b': '~/.config/dotfiles/bash/bashrc'},
            \   {'t': '~/.config/dotfiles/tmux/tmux.conf'},
            \   {'g': '~/.config/dotfiles/git/gitconfig'},
            \   {'r': '~/.config/dotfiles/ranger/rc.conf'},
            \]
let g:startify_skiplist = [
            \   $VIM_HOME,
            \   $HOME .'/.bashrc',
            \   '/usr/share/vim',
            \   '/usr/share/nvim',
            \   '/usr/local/Cellar/vim',
            \   '/usr/local/Cellar/neovim',
            \]

nnoremap <expr><silent> <leader>S utility#Open(":Startify\<CR>")
