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

function s:AutoCmdBufType() abort
    " if &previewwindow == 1
    "     set nobuflisted
    "     nnoremap <silent><buffer> <leader>q :pclose<CR>
    "     nnoremap <silent><buffer> q :pclose<CR>
    "     return
    " endif
    if &buftype ==# 'nofile'
        nnoremap <silent><buffer> <leader>q :q<CR>
        nnoremap <silent><buffer> q :q<CR>
    elseif &buftype ==# 'help'
        " open help window vertical split
        wincmd L
        nnoremap <silent><buffer> <leader>q :helpclose<CR>
        nnoremap <silent><buffer> q :helpclose<CR>
    elseif has('nvim') && &buftype ==# 'terminal'
        normal! i
        set nonumber
    endif
endfunction

augroup myBufType
    autocmd!
    autocmd BufEnter * call s:AutoCmdBufType()
augroup END

if !has('nvim')
    augroup mySource
        autocmd!
        " autocmd BufWritePost $MYVIMRC source %
        autocmd BufWritePost ~/.vim/plug.vim source %
        autocmd BufWritePost ~/.vim/common/*.vim source %
        autocmd BufWritePost ~/.vim/plugin/*.vim source %
        autocmd BufWritePost ~/.vim/autoload/*.vim source %
    augroup END
endif

augroup myFileType
    autocmd!
    autocmd BufNewFile,BufRead *.launch set filetype=xml
    autocmd BufNewFile,BufRead *.urdf set filetype=xml
    autocmd BufNewFile,BufRead *.BUILD set filetype=bzl
    autocmd BufNewFile,BufRead WORKSPACE set filetype=bzl
    autocmd BufNewFile,BufRead .arc* set filetype=json
    autocmd FileType c,cpp set cindent
augroup END

augroup myCommon
    autocmd!
    " autocmd WinEnter * autocmd BufWinEnter * clearjumps
    " autocmd WinNew * echo expand('%'). '~~~~~~~~'
    " autocmd WinNew * clearjumps
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
        autocmd TermOpen * nnoremap <silent><buffer> i :set nonumber<CR>i
    else
        autocmd TerminalOpen * call terminal#AutoCmdTerminal()
    endif
augroup END
