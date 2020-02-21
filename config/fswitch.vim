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

let s:source_locs = join([
            \   '.',
            \   '../src',
            \   '../source',
            \   'reg:/include/src/',
            \   'reg:/include.*/src/',
            \   'reg:/include/source/',
            \   'reg:/include.*/source/',
            \], ',')

let s:header_locs = join([
            \   '.',
            \   '../include',
            \   'reg:/src/include/',
            \   'reg:|src|include/**|',
            \   'reg:/source/include/',
            \   'reg:|source|include/**|',
            \], ',')

augroup myFSwitch
    autocmd!
    autocmd BufEnter *.h,*.hpp,*.hh let b:fswitchdst = 'cc,cpp,c'
                \| let b:fswitchlocs = s:source_locs
    autocmd BufEnter *.cc,*.cpp,*.c let b:fswitchdst = 'h,hpp,hh'
                \| let b:fswitchlocs = s:header_locs
augroup END

nnoremap <silent> <leader>h :FSHere<CR>
