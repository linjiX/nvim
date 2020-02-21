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
    if bufname('%') ==# '' && line('$') == 1 && getline(1) ==# ''
        let b:stored_bufhidden = &bufhidden
        set bufhidden=wipe
    endif
endfunction

augroup myBuffer
    autocmd!
    autocmd BufWinEnter * call s:AutoCmdBufType()
    autocmd BufLeave * call s:AutoCmdWipeEmptyBuf()
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
    autocmd BufNewFile,BufRead .arc* setlocal filetype=json
    autocmd FileType c,cpp setlocal cindent
    autocmd FileType proto setlocal shiftwidth=4
    autocmd FileType json setlocal foldnestmax=20
augroup END

augroup myCommon
    autocmd!
    autocmd VimEnter * clearjumps
    " Disable automatic comment insertion
    autocmd FileType * setlocal formatoptions-=cro
    " Locate cursor to the last position
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype !~# 'commit' |
                \     execute "normal g`\"" |
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
        autocmd QuitPre * call terminal#AutoCmdWipeTerminal()
    endif
augroup END
