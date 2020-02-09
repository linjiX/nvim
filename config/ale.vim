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
scriptencoding utf-8

let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \ 'vim': ['vint'],
            \ 'gitcommit': ['gitlint'],
            \ 'sh': ['shellcheck'],
            \ 'cpp': ['CppCheck', 'cpplint'],
            \ 'bzl': ['Buildifier'],
            \ 'python': ['flake8', 'pylint', 'mypy'],
            \ 'json': ['Jsonlint'],
            \ 'Dockerfile': ['hadolint'],
            \ 'cmake': ['cmakelint'],
            \ 'markdown': ['markdownlint-cli'],
            \ }
let g:ale_cpp_CppCheck_options = join([
            \ '--language=c++',
            \ '--std=c++17',
            \ '--enable=all',
            \ '--platform=unix64',
            \ '--suppress=unusedFunction',
            \ '--suppress=unusedStructMember',
            \ ])
let g:ale_cpp_cpplint_options = '--linelength=100 --filter='.
            \ '-build/c++11,'.
            \ '-build/include_order,'.
            \ '-readability/braces,'.
            \ '-whitespace/brace,'.
            \ '-whitespace/indent,'.
            \ '-runtime/references,'
let g:ale_python_flake8_options = '--max-line-length=100'
let g:ale_python_pylint_options = '--disable=bad-continuation'
let g:ale_python_mypy_options = join([
            \ '--cache-dir=/tmp/mypy_cache',
            \ '--ignore-missing-imports',
            \ '--follow-imports=silent',
            \ '--warn-unreachable',
            \ '--strict-equality',
            \ '--strict',
            \ ])
let g:ale_cmake_cmakelint_options = '--linelength=100'
let g:ale_markdown_markdownlint_cli_options = '--config='. $HOME .'/.vim/markdownlint.json'

let g:ale_echo_msg_format = '[%linter%][%severity%][%code%] %s'
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_sign_offset = 10000

let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_info = ''
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_warn_about_trailing_whitespace = 0

function s:ALEDiags()
    let g:ale_set_quickfix = 1
    ALELint
    belowright copen
    autocmd myALE WinLeave * ++once let g:ale_set_quickfix = 0
endfunction

function s:AutoCmdALEFixSuggest() abort
    wincmd L
    setlocal buftype=nofile
    setlocal nobuflisted
    setlocal bufhidden=wipe
    nnoremap <silent><buffer> <leader>q :q<CR>
    nnoremap <silent><buffer> q :q<CR>
endfunction

augroup myALE
    autocmd!
    autocmd BufRead * ALELint
    autocmd FileType ale-fix-suggest call s:AutoCmdALEFixSuggest()
augroup END

nnoremap <silent> <leader>D :call <SID>ALEDiags()<CR>
nnoremap <leader>E :ALEDetail<CR>

nmap [w <Plug>(ale_previous)
nmap ]w <Plug>(ale_next)
nmap [W <Plug>(ale_first)
nmap ]W <Plug>(ale_last)
