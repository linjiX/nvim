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

function s:AutoCmdFugitive() abort
    set nobuflisted
    nnoremap <silent><buffer> <leader>q :q<CR>
endfunction

function s:AutoCmdGV() abort
    set colorcolumn=0
endfunction

augroup myGit
    autocmd!
    autocmd FileType fugitive call <SID>AutoCmdFugitive()
    autocmd FileType GV call <SID>AutoCmdGV()
augroup END

cnoreabbrev <silent> Gstatus vertical botright Gstatus
