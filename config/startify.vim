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
            \   {'v': '~/.vim/vimrc'},
            \   {'p': '~/.vim/vimrc.plug'},
            \   {'c': '~/.vim/coc-settings.json'},
            \   {'s': '~/.vim/plug/coc.nvim/data/schema.json'},
            \   {'b': '~/.config/dotfiles/bashrc'},
            \   {'t': '~/.config/dotfiles/tmux.conf'},
            \   {'g': '~/.config/dotfiles/gitconfig'},
            \]
let g:startify_skiplist = [
            \   $HOME .'/.vim',
            \   $HOME .'/.bashrc',
            \   '/usr/share/vim',
            \   '/usr/share/nvim',
            \   '/usr/local/Cellar/vim',
            \   '/usr/local/Cellar/neovim',
            \]

nnoremap <expr><silent> <leader>S common#Open(":Startify\<CR>")
