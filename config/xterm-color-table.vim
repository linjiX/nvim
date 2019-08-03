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

augroup myXtermColorTable
    autocmd!
    autocmd BufEnter __XtermColorTable__ call <SID>AutoCmdXtermColorTable()
augroup END

function s:AutoCmdXtermColorTable() abort
    set bufhidden=delete
    set nobuflisted
    set nonumber
endfunction
