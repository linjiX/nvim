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

let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \   'vim': ['vint'],
            \   'gitcommit': ['gitlint'],
            \   'sh': ['shellcheck'],
            \   'cpp': ['CppCheck', 'cpplint'],
            \   'bzl': ['Buildifier'],
            \   'python': ['flake8', 'pylint', 'mypy'],
            \   'rst': ['rstcheck'],
            \   'json': ['Jsonlint'],
            \   'Dockerfile': ['hadolint'],
            \   'cmake': ['cmakelint'],
            \   'markdown': ['markdownlint-cli'],
            \   'xml': ['xmllint'],
            \   'yaml': ['yamllint'],
            \   'php': ['php', 'phpcs'],
            \}
let g:ale_gitcommit_gitlint_options = '--config='. $MY_LINTER_PATH .'/.gitlint'
let g:ale_cpp_CppCheck_options = join([
            \   '--language=c++',
            \   '--std=c++17',
            \   '--enable=all',
            \   '--platform=unix64',
            \   '--suppress=unknownMacro',
            \   '--suppress=unusedFunction',
            \   '--suppress=unusedStructMember',
            \])
let g:ale_cpp_cpplint_options = '--linelength=100 --filter='. join([
            \   '-build/c++11',
            \   '-build/include_order',
            \   '-readability/braces',
            \   '-whitespace/brace',
            \   '-whitespace/indent',
            \   '-runtime/references',
            \], ',')
let g:ale_python_flake8_options = join([
            \   '--max-line-length=100',
            \   '--docstring-style=google',
            \   '--docstring-convention=google',
            \   '--rst-roles=class',
            \   '--ignore-decorators=overload',
            \   '--ignore=E203,W503,D105,D107,DAR203,RST',
            \])
let g:ale_python_pylint_options = join([
            \   '--min-public-methods=0',
            \   '--good-names=i,j,m,n,k,x,y,z,w,fp,df,tz',
            \   '--disable=bad-continuation',
            \   '--generated-members=torch.*,cv2.*',
            \   '--ignored-modules=tensorflow.compat.v1'
            \])
let g:ale_python_mypy_options = join([
            \   '--cache-dir=/tmp/mypy_cache',
            \   '--ignore-missing-imports',
            \   '--follow-imports=silent',
            \   '--warn-unreachable',
            \   '--show-error-codes',
            \   '--strict-equality',
            \   '--strict',
            \])
let g:ale_yaml_yamllint_options = '--config-file='. $MY_LINTER_PATH .'/.yamllint'
let g:ale_cmake_cmakelint_options = '--linelength=100'
let g:ale_markdown_markdownlint_cli_options = '--config='. $MY_LINTER_PATH .'/markdownlint.json'

let g:ale_php_phpcs_options = '--standard='. $MY_LINTER_PATH .'/phpcs.xml'

let g:ale_echo_msg_format = '[%linter%][%severity%][%code%] %s'
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 1
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

nnoremap [ra :ALEEnable<CR>
nnoremap ]ra :ALEDisable<CR>
nnoremap yra :ALEToggle<CR>

nnoremap [rA :ALEEnableBuffer<CR>
nnoremap ]rA :ALEDisableBuffer<CR>
nnoremap yrA :ALEToggleBuffer<CR>

scriptencoding utf-8
