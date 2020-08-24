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

let g:polyglot_disabled = ['sh']

" Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
"let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_concepts_highlight = 1

" Plug 'chrisbra/csv.vim'
let g:csv_nomap_cr = 1
let g:csv_nomap_bs = 1
let g:csv_nomap_space = 1

" Plug 'plasticboy/vim-markdown'
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_auto_insert_bullets = 0

" Plug 'Vimjas/vim-python-pep8-indent'
augroup myPolyglot
    autocmd!
    autocmd FileType bzl setlocal indentexpr=GetPythonPEPIndent(v:lnum)
augroup END
