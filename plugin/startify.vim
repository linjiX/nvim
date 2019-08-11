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
            \ {'v': '~/.vim/vimrc'},
            \ {'p': '~/.vim/plug.vim'},
            \ {'y': '~/.vim/ycm_extra_conf.py'},
            \ {'b': '~/.config/dotfiles/bashrc'},
            \ {'t': '~/.config/dotfiles/tmux.conf'},
            \ ]
let g:startify_skiplist = [
            \ $HOME .'/.vim',
            \ $HOME .'/.bashrc',
            \ "/usr/share/nvim",
            \ "/usr/share/vim",
            \ ]

nnoremap <expr> <leader>S BufferCmd(":Startify\<CR>")
