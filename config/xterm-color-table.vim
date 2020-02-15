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

let g:XtermColorTableDefaultOpen = 'vertical botright vsplit'

function s:AutoCmdXtermColorTable() abort
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal nonumber
    setlocal colorcolumn=0
    normal! gg
endfunction

augroup myXtermColorTable
    autocmd!
    autocmd BufEnter __XtermColorTable__ call s:AutoCmdXtermColorTable()
augroup END
