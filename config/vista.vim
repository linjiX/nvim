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

let s:minwidth = 30
let s:ratio = 0.148
let s:width = max([float2nr(&columns * s:ratio), s:minwidth])

function s:ToggleDefxVista() abort
    let g:defx_vista_width = max([float2nr(&columns * s:ratio), s:minwidth])
    ToggleDefxVista
endfunction

nnoremap <silent> <leader>w :call <SID>ToggleDefxVista()<CR>

" Vista
let g:vista_sidebar_position = 'vertical topleft'
let g:vista_sidebar_width = s:width
let g:vista_icon_indent = ['﬌ ', 'ﲖ ']

let g:vista_executive_for = {
            \ 'markdown': 'toc',
            \ }

" Defx
augroup myDefx
    autocmd!
    autocmd FileType defx call s:DefxMappings()
    autocmd FileType defx call s:DefxGitMappings()
augroup END

call defx#custom#option('_', {
            \ 'winwidth': s:width,
            \ 'split': 'vertical',
            \ 'direction': 'topleft',
            \ 'show_ignored_files': 0,
            \ 'buffer_name': '',
            \ 'toggle': 1,
            \ 'resume': 1,
            \ 'columns': 'indent:git:icons:filename:type',
            \ 'root_marker': '[]',
            \ })

function s:DefxMappings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ? defx#do_action('open_or_close_tree')
                \                     : defx#do_action('multi', ['drop'])
    nnoremap <silent><buffer><expr> x
                \ defx#do_action('close_tree')
    nnoremap <silent><buffer><expr> s
                \ defx#do_action('multi',[['drop','split']])
    nnoremap <silent><buffer><expr> v
                \ defx#do_action('multi',[['drop','vsplit']])
    nnoremap <silent><buffer><expr> t
                \ defx#do_action('multi',[['drop','tabedit']])

    nnoremap <silent><buffer><expr> I
                \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> zh
                \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> yp
                \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> <C-g>
                \ defx#do_action('print')

    nnoremap <silent><buffer><expr> cw
                \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> yy
                \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> p
                \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> dd
                \ defx#do_action('move')
    nnoremap <silent><buffer><expr> <C-n>
                \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> dD
                \ defx#do_action('remove')

    nnoremap <silent><buffer><expr> i
                \ defx#do_action('toggle_columns',
                \                'indent:git:icons:filename:type:size:time')

    nnoremap <silent><buffer><expr> om
                \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> os
                \ defx#do_action('toggle_sort', 'size')
    nnoremap <silent><buffer><expr> ob
                \ defx#do_action('toggle_sort', 'filename')
    nnoremap <silent><buffer><expr> oe
                \ defx#do_action('toggle_sort', 'extension')

    nnoremap <silent><buffer><expr> !
                \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> O
                \ defx#do_action('execute_system')

    nnoremap <silent><buffer><expr> .
                \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> u
                \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> gh
                \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> C
                \ defx#do_action('cd', defx#get_candidate().action__path)
    nnoremap <silent><buffer><expr> cd
                \ defx#do_action('change_vim_cwd')

    nnoremap <silent><buffer><expr> V
                \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> ~
                \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> <C-v>
                \ defx#do_action('clear_select_all')

    nnoremap <silent><buffer><expr> q
                \ defx#do_action('quit')
endfunction

function s:DefxGitMappings() abort
    nnoremap <silent><buffer> <leader>ga <Plug>(defx-git-stage)
    nnoremap <silent><buffer> <leader>gA <Plug>(defx-git-reset)
    nnoremap <silent><buffer> <leader>gu <Plug>(defx-git-discard)
endfunction
