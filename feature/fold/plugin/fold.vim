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

augroup myFold
    autocmd!
    autocmd FileType json setlocal foldmethod=syntax
    autocmd FileType markdown setlocal foldmethod=expr | setlocal foldexpr=fold#markdown#Expr()
    autocmd FileType vim setlocal foldmethod=expr | setlocal foldexpr=fold#vimscript#Expr()
    autocmd FileType python setlocal foldmethod=expr | setlocal foldexpr=fold#python#Expr()
augroup END
