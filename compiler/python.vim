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

if exists('current_compiler')
    finish
endif

let current_compiler = 'python'

if exists(':CompilerSet') != 2
    command -nargs=* CompilerSet setlocal <args>
endif

" reference: https://github.com/sheerun/vim-polyglot/blob/master/compiler/python.vim
CompilerSet makeprg=python
CompilerSet errorformat=
            \%+GTraceback%.%#,
            \%E\ \ File\ \"%f\"\\,\ line\ %l\\,%m%\\C,
            \%E\ \ File\ \"%f\"\\,\ line\ %l%\\C,
            \%C%p^,
            \%+C\ \ \ \ %.%#,
            \%+C\ \ %.%#,
            \%Z%\\S%\\&%m,

