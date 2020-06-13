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

if has('nvim')
    nnoremap <silent> <leader>K :Man<CR>

    function s:AutoCmdMan() abort
        wincmd L
        setlocal bufhidden=wipe
        setlocal nobuflisted
    endfunction
else
    runtime ftplugin/man.vim
    let g:ft_man_open_mode = 'vert'

    function s:AutoCmdMan() abort
        setlocal bufhidden=wipe
        setlocal nolist
    endfunction
endif

augroup myMan
    autocmd!
    autocmd FileType man call s:AutoCmdMan()
augroup END
