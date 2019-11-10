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
let s:minwidth = 30
let s:ratio = 0.148
let s:testwidth = max([float2nr(&columns * s:ratio), s:minwidth])

" Vista
let g:vista_sidebar_position = 'vertical topleft'
let g:vista_sidebar_width = s:testwidth

augroup myDefx
    autocmd!
    autocmd FileType defx call s:DefxMappings()
augroup END

" Defx
call defx#custom#option('_', {
            \ 'winwidth': s:testwidth,
            \ 'split': 'vertical',
            \ 'direction': 'topleft',
            \ 'show_ignored_files': 0,
            \ 'buffer_name': '',
            \ 'toggle': 1,
            \ 'resume': 1,
            \ 'root_marker': '[]',
            \ })

function s:DefxMappings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ? defx#do_action('open_or_close_tree')
                \                     : defx#do_action('multi', ['drop'])
    nnoremap <silent><buffer><expr> x
                \ defx#do_action('close_tree')
    nnoremap <silent><buffer><expr> I
                \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> yp
                \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> s
                \ defx#do_action('multi',[['drop','split']])
    nnoremap <silent><buffer><expr> v
                \ defx#do_action('multi',[['drop','vsplit']])
    nnoremap <silent><buffer><expr> t
                \ defx#do_action('multi',[['drop','tabedit']])

    nnoremap <silent><buffer><expr> cw
                \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> yy
                \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> p
                \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> dd
                \ defx#do_action('move')
    nnoremap <silent><buffer><expr> N
                \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> dD
                \ defx#do_action('remove')

    nnoremap <silent><buffer><expr> i
                \ defx#do_action('toggle_columns',
                \                'mark:indent:icon:filename:type:size:time')

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

    nnoremap <silent><buffer><expr> V
                \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
                \ defx#do_action('toggle_select_all')

    nnoremap <silent><buffer><expr> cd
                \ defx#do_action('change_vim_cwd')

    nnoremap <silent><buffer><expr> <C-g>
                \ defx#do_action('print')

    nnoremap <silent><buffer><expr> q
                \ defx#do_action('quit')
endfunction

function s:HasDefx() abort
    let l:bufs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    let l:bufs = filter(l:bufs, 'getbufvar(v:val, "&filetype") ==# "defx"')
    return len(l:bufs) >= 1
endfunction

function s:ToggleDefxVista() abort
    let l:has_defx = s:HasDefx()
    let l:has_vista = vista#sidebar#IsVisible()

    if l:has_defx
        Defx -toggle
    endif

    if l:has_vista
        Vista!
    endif

    if l:has_defx || l:has_vista
        return
    endif

    let s:source_winid = win_getid()

    if exists('g:vista_sidebar_position')
        let l:vista_sidebar_position_user = g:vista_sidebar_position
    endif
    if exists('g:vista_sidebar_width')
        let l:vista_sidebar_width_user = g:vista_sidebar_width
    endif

    let g:vista_sidebar_position = 'vertical topleft'
    let g:vista_sidebar_width = s:testwidth
    autocmd myDefx User VistaWinOpen ++once call s:OpenDefx()
    Vista
endfunction

function s:OpenDefx() abort
    setlocal nowinfixheight
    setlocal winfixwidth

    call defx#custom#option('_', 'prev_winid', s:source_winid)
    Defx -split='horizontal' -direction='aboveleft' -no-winwidth -no-winheight
    let l:option = defx#custom#_get().option._
    unlet l:option.prev_winid

    setlocal nowinfixheight
    setlocal winfixwidth

    call win_gotoid(s:source_winid)
endfunction

nnoremap <silent> <leader>w :call <SID>ToggleDefxVista()<CR>
