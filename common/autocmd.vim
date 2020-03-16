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
let s:minwidth = 30
let s:ratio = 0.148
function SiderBarWidth()
    return max([float2nr(&columns * s:ratio), s:minwidth])
endfunction

function s:AutoCmdBufType() abort
    if &buftype ==# 'nofile'
        nnoremap <silent><buffer> <leader>q :q<CR>
        nnoremap <silent><buffer> q :q<CR>
    elseif &buftype ==# 'help'
        " open help window vertical split
        wincmd L
        nnoremap <silent><buffer> <leader>q :helpclose<CR>
        nnoremap <silent><buffer> q :helpclose<CR>
    endif
endfunction

function s:AutoCmdWipeEmptyBuf() abort
    if exists('b:stored_bufhidden')
        let &bufhidden = b:stored_bufhidden
        unlet b:stored_bufhidden
    endif
    if empty(bufname('%')) && line('$') == 1 && empty(getline(1))
        let b:stored_bufhidden = &bufhidden
        set bufhidden=wipe
    endif
endfunction

augroup myBuffer
    autocmd!
    autocmd BufWinEnter * call s:AutoCmdBufType()
    autocmd BufLeave * call s:AutoCmdWipeEmptyBuf()
augroup END

let s:large_file_limit = 2
function s:AutoCmdLargeFile(filename) abort
    let l:size = getfsize(a:filename)
    if l:size > s:large_file_limit * 1024 * 1024 || l:size == -2
        call large#handle()
    endif
endfunction

augroup myLargeFile
    autocmd!
    autocmd BufReadPre * call s:AutoCmdLargeFile(expand('<afile>'))
augroup END

augroup mySource
    autocmd!
    if has('nvim')
        autocmd BufWritePost $MYVIMRC source %
    endif
    autocmd BufWritePost ~/.vim/vimrc.plug source %
    autocmd BufWritePost ~/.vim/common/*.vim source %
    autocmd BufWritePost ~/.vim/config/*.vim source %
    autocmd BufWritePost ~/.vim/autoload/*.vim source %
augroup END

augroup myFileType
    autocmd!
    autocmd BufNewFile,BufRead *.launch setlocal filetype=xml
    autocmd BufNewFile,BufRead *.urdf setlocal filetype=xml
    autocmd BufNewFile,BufRead *.BUILD setlocal filetype=bzl
    autocmd BufNewFile,BufRead BUILD.* setlocal filetype=bzl
    autocmd BufNewFile,BufRead .arc*,*.book setlocal filetype=json
    autocmd BufNewFile,BufRead new-commit,differential-update-comments setlocal filetype=arcdiff
    autocmd BufNewFile,BufRead *.diviner setlocal filetype=markdown

    autocmd FileType c,cpp setlocal cindent
    autocmd FileType proto setlocal shiftwidth=4
    autocmd FileType gitcommit setlocal colorcolumn=72
    autocmd FileType arcdiff setlocal colorcolumn=72 | setlocal commentstring=#%s

    autocmd FileType json setlocal foldmethod=syntax
    autocmd FileType markdown setlocal foldmethod=expr | setlocal foldexpr=fold#markdown#Expr()
    autocmd FileType vim setlocal foldmethod=expr | setlocal foldexpr=fold#vimscript#Expr()
    autocmd FileType python setlocal foldmethod=expr | setlocal foldexpr=fold#python#Expr()

    " Disable automatic comment insertion
    autocmd FileType * setlocal formatoptions-=cro
augroup END

augroup myCommon
    autocmd!
    autocmd VimEnter * clearjumps
    " Locate cursor to the last position
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype !~# 'commit' |
                \     execute "normal! g`\"" |
                \ endif
augroup END

augroup myQuickFix
    autocmd!
    autocmd FileType qf call quickfix#AutoCmdQuickFix()
    autocmd QuickFixCmdPost [^l]* nested belowright cwindow
    autocmd QuickFixCmdPost    l* nested belowright lwindow
augroup END

augroup myTerminal
    autocmd!
    if has('nvim')
        autocmd TermOpen * call terminal#AutoCmdTerminal()
        autocmd TermClose * quit
        autocmd BufEnter term://* call terminal#AutoCmdNvimTerminal()
    else
        autocmd TerminalOpen * call terminal#AutoCmdTerminal()
    endif
augroup END
