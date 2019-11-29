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
augroup myFSwitch
    autocmd!
    autocmd BufEnter *.h let b:fswitchdst = 'cc,cpp,c'
    autocmd BufEnter *.h let b:fswitchlocs = join([
                \ '.',
                \ '../src',
                \ '../source',
                \ 'reg:/include/src/',
                \ 'reg:/include.*/src/',
                \ 'reg:/include/source/',
                \ 'reg:/include.*/source/',
                \ ], ',')
    autocmd BufEnter *.c* let b:fswitchdst = 'h'
    autocmd BufEnter *.c* let b:fswitchlocs = join([
                \ '.',
                \ '../include',
                \ 'reg:/src/include/',
                \ 'reg:|src|include/**|',
                \ 'reg:/source/include/',
                \ 'reg:|source|include/**|',
                \ ], ',')
augroup END

nnoremap <silent> <leader>h :FSHere<CR>
