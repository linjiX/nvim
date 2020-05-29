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

function s:AutoCmdFSwitchCPP() abort
    let l:extension = expand('<afile>:e')
    if index(['h', 'hpp', 'hh'], l:extension) != -1
        let b:fswitchdst = 'cc,cpp,c'
        let b:fswitchlocs = join([
                    \   '.',
                    \   '../src',
                    \   '../source',
                    \   'reg:/include/src/',
                    \   'reg:/include.*/src/',
                    \   'reg:/include/source/',
                    \   'reg:/include.*/source/',
                    \], ',')
    elseif index(['cc', 'cpp', 'c'], l:extension) != -1
        let b:fswitchdst = 'h,hpp,hh'
        let b:fswitchlocs = join([
                    \   '.',
                    \   '../include',
                    \   'reg:/src/include/',
                    \   'reg:|src|include/**|',
                    \   'reg:/source/include/',
                    \   'reg:|source|include/**|',
                    \], ',')
    else
        throw 'CPP file extension not recognized'
    endif
endfunction

function s:AutoCmdFSwitchVIM() abort
    let b:fswitchdst = 'vim'
    let b:fswitchlocs = join([
                \   'reg:/autoload/plugin/',
                \   'reg:/plugin/autoload',
                \], ',')
endfunction

augroup myFSwitch
    autocmd!
    autocmd FileType c,cpp call s:AutoCmdFSwitchCPP()
    autocmd FileType vim call s:AutoCmdFSwitchVIM()
augroup END

nnoremap <silent> <leader>h :FSHere<CR>
