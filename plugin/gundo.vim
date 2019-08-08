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

if has('python3')
    let g:gundo_prefer_python3 = 1
endif

let g:gundo_right = 1
let g:gundo_width = 70
let g:gundo_preview_height = 15
let g:gundo_close_on_revert = 1
" let g:gundo_auto_preview = 0

nnoremap <leader>G :GundoToggle<CR>
