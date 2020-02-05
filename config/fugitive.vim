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
    setlocal nobuflisted
    nnoremap <silent><buffer> <leader>q :q<CR>
endfunction

function s:AutoCmdGV() abort
    setlocal colorcolumn=0
endfunction

augroup myGit
    autocmd!
    autocmd FileType fugitive call s:AutoCmdFugitive()
    autocmd FileType GV call s:AutoCmdGV()
augroup END

command! Gst vertical botright Gstatus
command! -nargs=? -complete=customlist,fugitive#CommitComplete Gc execute 'Gcommit -v '. <q-args>
