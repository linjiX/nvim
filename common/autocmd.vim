""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    https://github.com/linjiX/nvim                                "
"     _  _          _  _ __  __    __             _                "
"    | |(_) _ __   (_)(_)\ \/ /   / /_ __ __   __(_) _ __ ___      "
"    | || || '_ \  | || | \  /   / /| '_ \\ \ / /| || '_ ` _ \     "
"    | || || | | | | || | /  \  / / | | | |\ V / | || | | | | |    "
"    |_||_||_| |_|_/ ||_|/_/\_\/_/  |_| |_| \_/  |_||_| |_| |_|    "
"                |__/                                              "
"                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

augroup myBufferType
    autocmd!
    autocmd BufWinEnter * call s:AutoCmdBufType()
augroup END

augroup mySource
    autocmd!
    " autocmd BufWritePost $MYVIMRC source %
    autocmd BufWritePost $VIM_HOME/plugs.vim source %
    autocmd BufWritePost $VIM_HOME/autoload/*.vim source %
    autocmd BufWritePost $VIM_HOME/common/*.vim source %
    autocmd BufWritePost $VIM_HOME/config/*.vim source %
    autocmd BufWritePost $VIM_HOME/feature/*.vim source %
augroup END

augroup myFileType
    autocmd!
    autocmd BufNewFile,BufRead Dockerfile.* setlocal filetype=Dockerfile
    autocmd BufNewFile,BufRead *.launch,*urdf setlocal filetype=xml
    autocmd BufNewFile,BufRead .clang-format,yamllint setlocal filetype=yaml
    autocmd BufNewFile,BufRead *.BUILD,BUILD.* setlocal filetype=bzl
    autocmd BufNewFile,BufRead *.conf,.*config setlocal filetype=conf
    autocmd BufNewFile,BufRead .bazelrc,.gitlint setlocal filetype=conf

    autocmd FileType c,cpp setlocal cindent
    autocmd FileType proto setlocal shiftwidth=4
    autocmd FileType conf setlocal commentstring=#%s
    autocmd FileType python setlocal nosmartindent | compiler python
    autocmd FileType sh compiler bash

    " Disable automatic comment insertion
    autocmd FileType * setlocal formatoptions-=cro
augroup END

function s:AutoCmdRestoreCursor() abort
    " Locate cursor to the last position
    let l:bufnr = str2nr(expand('<abuf>'))
    if getbufvar(l:bufnr, 'restore_cursor', v:false)
        return
    endif
    call setbufvar(l:bufnr, 'restore_cursor', v:true)

    let l:line = line("'\"")
    if l:line > 1 && l:line <= line('$') && &filetype !~# 'commit'
        execute "normal! g`\""
    endif
endfunction

augroup myCommon
    autocmd!
    autocmd VimEnter * clearjumps
    autocmd BufReadPost * call s:AutoCmdRestoreCursor()
augroup END

augroup myQuickFix
    autocmd!
    autocmd FileType qf call quickfix#AutoCmdQuickFix()
    " autocmd QuickFixCmdPost [^l]* nested belowright cwindow
    " autocmd QuickFixCmdPost    l* nested belowright lwindow
augroup END
