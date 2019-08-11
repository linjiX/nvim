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
    if &buftype == 'nofile'
        if expand("%:t") == "__Gundo__"
            nnoremap <silent><buffer> <leader>q :GundoHide<CR>
        else
            nnoremap <silent><buffer> <leader>q :q<CR>
            nnoremap <silent><buffer> q :q<CR>
        endif
    elseif &buftype == 'help'
        " open help window vertical split
        wincmd L
        nnoremap <silent><buffer> <leader>q :helpclose<CR>
        nnoremap <silent><buffer> q :helpclose<CR>
    endif
    if &previewwindow == 1
        set nobuflisted
    endif
endfunction

augroup myBufType
    autocmd!
    autocmd BufEnter * call <SID>AutoCmdBufType()
augroup END

augroup mySource
    autocmd!
    autocmd BufWritePost ~/.vim/plug.vim source %
    autocmd BufWritePost ~/.vim/common/*.vim source %
    autocmd BufWritePost ~/.vim/plugin/*.vim source %
augroup END

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
    " Disable automatic comment insertion
    autocmd FileType * setlocal formatoptions-=cro
    " Close VIM when only no listed buffer window visable
    autocmd WinEnter *
                \ if winnr('$') == 1 &&
                \    getbufvar(winbufnr(winnr()), "&buflisted") == 0 &&
                \    getbufvar(winbufnr(winnr()), "&filetype") != 'startify'|
                \     q |
                \ endif
    " Locate cursor to the last position
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype !~# 'commit' |
                \     execute "normal g`\"" |
                \ endif
augroup END

function BufferCmd(cmd) abort
    let l:wincmd = ''
    if (&buflisted == 0 && winnr('$') > 1)
        let l:win = filter(range(1, winnr('$')), 'getbufvar(winbufnr(v:val), "&buflisted") == 1')
        if len(l:win) >= 1
            let l:wincmd = ':'. l:win[0] ."wincmd w\<CR>"
        endif
    endif
    return l:wincmd . a:cmd
endfunction

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
        autocmd BufEnter * if &buftype == 'terminal' | normal i | endif
    else
        autocmd TerminalOpen * call terminal#AutoCmdTerminal()
    endif
augroup END
