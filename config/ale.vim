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
            \ 'python': ['flake8'],
            \ 'json': ['Jsonlint'],
            \ 'Dockerfile': ['hadolint'],
            \ 'cmake': ['cmakelint'],
            \ }
let g:ale_cpp_cpplint_options = '--linelength=100 --filter='.
            \ '-build/c++11,'.
            \ '-build/include_order,'.
            \ '-readability/braces,'.
            \ '-whitespace/brace,'.
            \ '-whitespace/indent,'
let g:ale_python_flake8_options = '--max-line-length=99'
let g:ale_cmake_cmakelint_options = '--linelength=100'

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

call ale#linter#Define('cpp', {
            \   'name': 'CppCheck',
            \   'output_stream': 'both',
            \   'executable': 'cppcheck',
            \   'command': '%e -q --language=c++ --std=c++14 --enable=all --platform=unix64 '.
            \              '--suppress=unusedFunction '.
            \              '--suppress=unusedStructMember '.
            \              '--template="{file}:{line}:{column} {severity}:{id}:{message}" '.
            \              '--template-location="{file}:{line}:{column} {info}" %t',
            \   'callback': 'HandleCppCheckFormat',
            \})

function HandleCppCheckFormat(buffer, lines) abort
    let l:pattern = '\v^(.+):(\d+):(\d+) (.+):(.+):(.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            call add(l:output, {
                        \   'lnum': str2nr(l:match[2]),
                        \   'col': str2nr(l:match[3]),
                        \   'type': l:match[4] is# 'error' ? 'E' : 'W',
                        \   'code': l:match[5],
                        \   'text': l:match[6],
                        \   'detail': l:match[1] .':'. l:match[2] .':'. l:match[3]
                        \             ."\ntype: ". l:match[4]
                        \             ."\ncode: ". l:match[5]
                        \             ."\ntext: ". l:match[6],
                        \})
        endif
    endfor

    let l:pattern_location = '\v^(.+):(\d+):(\d+) (.+)$'
    for l:match in ale#util#GetMatches(a:lines, l:pattern_location)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            let l:lnum = str2nr(l:match[2])
            let l:flag = 1
            for l:item in l:output
                if l:lnum == l:item['lnum'] && l:item['type'] !=# 'I'
                    let l:flag = 0
                    break
                endif
            endfor
            if l:flag == 1
                call add(l:output, {
                            \   'lnum': l:lnum,
                            \   'col': str2nr(l:match[3]),
                            \   'type': 'I',
                            \   'code': '~',
                            \   'text': l:match[4],
                            \   'detail': l:match[1] .':'. l:match[2] .':'. l:match[3]
                            \             ."\ntext: ". l:match[4],
                            \})
            endif
        endif
    endfor

    return l:output
endfunction

call ale#linter#Define('bzl', {
            \   'name': 'Buildifier',
            \   'output_stream': 'both',
            \   'executable': 'buildifier',
            \   'command': '%e --lint=warn --format=json --mode=check %t',
            \   'callback': 'HandleBuildifierFormat',
            \})

function HandleBuildifierFormat(buffer, lines) abort
    let l:pattern = '\v^(.+):(\d+):(\d+): (.+)$'
    let l:output = []
    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            call add(l:output, {
                        \   'lnum': l:match[2],
                        \   'col': l:match[3],
                        \   'type': 'E',
                        \   'code': '~',
                        \   'text': l:match[4],
                        \   'detail': l:match[1]
                        \             .':'. l:match[2]
                        \             .':'. l:match[3]
                        \             ."\ntext: ". l:match[4]
                        \})
        endif
    endfor
    if len(l:output) >= 1
        return l:output
    endif

    let l:json = json_decode(a:lines[0])
    if l:json['success']
        return []
    endif

    for l:file in l:json['files']
        for l:warning in l:file['warnings']
            if ale#path#IsBufferPath(a:buffer, l:file['filename'])
                call add(l:output, {
                            \   'lnum': l:warning['start']['line'],
                            \   'end_lnum': l:warning['end']['line'],
                            \   'col': l:warning['start']['column'],
                            \   'end_col': l:warning['end']['column'],
                            \   'type': 'W',
                            \   'code': l:warning['category'],
                            \   'text': l:warning['message'],
                            \   'detail': l:file['filename']
                            \             .':'. l:warning['start']['line']
                            \             .':'. l:warning['start']['column']
                            \             .' -> '. l:warning['end']['line']
                            \             .':'. l:warning['end']['column']
                            \             ."\ncode: ". l:warning['category']
                            \             ."\ntext: ". l:warning['message']
                            \             ."\nurl: ". l:warning['url'],
                            \})
            endif
        endfor
    endfor

    return l:output
endfunction

call ale#linter#Define('json', {
            \   'name': 'Jsonlint',
            \   'output_stream': 'both',
            \   'executable': 'jsonlint',
            \   'command': '%e %t',
            \   'callback': 'HandleJsonlintFormat',
            \})

function HandleJsonlintFormat(buffer, lines) abort
    let l:pattern = '\v^(.+):(\d+):(\d+): (.{-}): (.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        if ale#path#IsBufferPath(a:buffer, l:match[1])
            call add(l:output, {
                        \   'lnum': str2nr(l:match[2]),
                        \   'col': str2nr(l:match[3]),
                        \   'type': l:match[4] is# 'Error' ? 'E'
                        \                                  : l:match[4] is# 'Warning' ? 'W'
                        \                                                             : 'I',
                        \   'text': l:match[5],
                        \   'detail': l:match[1] .':'. l:match[2] .':'. l:match[3]
                        \             ."\ntype: ". l:match[4]
                        \             ."\ntext: ". l:match[5],
                        \})
        endif
    endfor

    return l:output
endfunction

function ALEDiags()
    let g:ale_set_quickfix = 1
    ALELint
    belowright copen
    autocmd myALE WinLeave * ++once let g:ale_set_quickfix = 0
endfunction

function s:AutoCmdALEFixSuggest() abort
    setlocal buftype=nofile
    setlocal nobuflisted
    setlocal bufhidden=wipe
    nnoremap <silent><buffer> <leader>q :q<CR>
    nnoremap <silent><buffer> q :q<CR>
endfunction

augroup myALE
    autocmd!
    autocmd BufRead * ALELint
    autocmd FileType ale-fix-suggest call <SID>AutoCmdALEFixSuggest()
augroup END

nnoremap <silent> <leader>D :call ALEDiags()<CR>
nnoremap <leader>E :ALEDetail<CR>

nmap [w <Plug>(ale_previous)
nmap ]w <Plug>(ale_next)
nmap [W <Plug>(ale_first)
nmap ]W <Plug>(ale_last)
