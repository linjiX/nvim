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

augroup myArc
    autocmd!
    autocmd BufNewFile,BufRead .arc*,*.book setlocal filetype=json
    autocmd BufNewFile,BufRead new-commit,differential-update-comments setlocal filetype=arcdiff
    autocmd BufNewFile,BufRead *.diviner setlocal filetype=markdown

    autocmd FileType arcdiff setlocal colorcolumn=72 commentstring=#%s
augroup END

if !exists('g:fugitive_browse_handlers')
    let g:fugitive_browse_handlers = []
endif

if index(g:fugitive_browse_handlers, function('arc#FugitiveUrl')) == -1
    call insert(g:fugitive_browse_handlers, function('arc#FugitiveUrl'))
endif

command! -nargs=? ABrowse call arc#Browse(<q-args>)
