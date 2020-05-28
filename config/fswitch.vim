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

let g:fsnonewfiles = 1

let s:cpp_source_locs = join([
            \   '.',
            \   '../src',
            \   '../source',
            \   'reg:/include/src/',
            \   'reg:/include.*/src/',
            \   'reg:/include/source/',
            \   'reg:/include.*/source/',
            \], ',')

let s:cpp_header_locs = join([
            \   '.',
            \   '../include',
            \   'reg:/src/include/',
            \   'reg:|src|include/**|',
            \   'reg:/source/include/',
            \   'reg:|source|include/**|',
            \], ',')

let s:vim_locs = join([
            \   'reg:/autoload/plugin/',
            \   'reg:/plugin/autoload',
            \], ',')

augroup myFSwitch
    autocmd!
    autocmd BufEnter *.h,*.hpp,*.hh let b:fswitchdst = 'cc,cpp,c'
                \| let b:fswitchlocs = s:cpp_source_locs
    autocmd BufEnter *.cc,*.cpp,*.c let b:fswitchdst = 'h,hpp,hh'
                \| let b:fswitchlocs = s:cpp_header_locs
    autocmd FileType vim let b:fswitchdst = 'vim'
                \| let b:fswitchlocs = s:vim_locs
augroup END

nnoremap <silent> <leader>h :FSHere<CR>
