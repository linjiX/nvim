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

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

let g:formatdef_clang_format = "'clang-format ".
            \                  "-lines='.a:firstline.':'.a:lastline.' ".
            \                  "--assume-filename=\"'.expand('%:p').'\" ".
            \                  "-style=file'"
let g:formatters_cpp = ['clang_format']
let g:formatters_proto = ['clang_format']

let g:formatdef_buildifier = "'buildifier'"
let g:formatters_bzl = ['buildifier']

let g:formatdef_black_isort = "'black -q -l 100 - | isort -'"
let g:formatters_python = ['black_isort']

let g:formatdef_prettier = "'prettier --print-width=100 --tab-width=4 ".
            \              "--parser='.&filetype.' --stdin'"
let g:formatdef_json_tool = "'python3 -m json.tool'"
" let g:formatters_json = ['json_tool']
let g:formatters_json = ['prettier']
let g:formatters_markdown = ['prettier']

let g:formatters_sh = ['shfmt']

let g:formatdef_cmake_format = "'cmake-format --line-width=100 --tab-size=4 --enable-markup=false -'"
let g:formatters_cmake = ['cmake_format']

let g:autoformat_verbosemode = 0

nnoremap <silent> <leader>a :Autoformat<CR>
vnoremap <silent> <leader>a :Autoformat<CR>
