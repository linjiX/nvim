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

let s:large_file_limit = 2

function s:LargeFile(filename) abort
    let l:size = getfsize(a:filename)
    if l:size > s:large_file_limit * 1024 * 1024 || l:size == -2
        call large#handle()
    endif
endfunction

augroup myLarge
    autocmd!
    autocmd BufReadPre * call s:LargeFile(expand('<afile>'))
augroup END
