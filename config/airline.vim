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

" Plug 'vim-airline/vim-airline-themes'
let g:airline_solarized_enable_command_color = 1
let g:airline_solarized_dark_inactive_background = 1

" Plug 'vim-airline/vim-airline'
call airline#parts#define_function('hunks', 'CocGitStatus')

call airline#parts#define_accent('coc_status', 'none')
call airline#parts#define_minwidth('coc_status', 100)

let g:airline_powerline_fonts = 1
let g:airline_filetype_overrides = {
            \   'coc-explorer':  ['coc-explorer', ''],
            \   'startify': [ 'Startify', '' ],
            \   'fugitiveblame': [ 'fugitiveblame', '' ],
            \}

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.dirty='*'
let g:airline_symbols.readonly = ' '
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.whitespace = ''

let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'

let g:airline#extensions#hunks#non_zero_only = 1

let g:airline#extensions#ale#show_line_numbers = 0

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#ignore_bufadd_pat = join([
            \    '!',
            \    '\[coc-explorer\]',
            \    '<__tagbar__>',
            \    '<undotree_',
            \    '<diffpanel_',
            \    '\[defx\]',
            \    '^term://',
            \], '|')

let g:airline#extensions#whitespace#long_format = 'L[%s]'
let g:airline#extensions#whitespace#trailing_format = 'T[%s]'
let g:airline#extensions#whitespace#conflicts_format = 'C[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'i[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'I[%s]'
let g:airline#extensions#whitespace#skip_indent_check_ft = {'markdown': ['trailing']}

nmap <expr> <leader>1 buffer#Open('<Plug>AirlineSelectTab1')
nmap <expr> <leader>2 buffer#Open('<Plug>AirlineSelectTab2')
nmap <expr> <leader>3 buffer#Open('<Plug>AirlineSelectTab3')
nmap <expr> <leader>4 buffer#Open('<Plug>AirlineSelectTab4')
nmap <expr> <leader>5 buffer#Open('<Plug>AirlineSelectTab5')
nmap <expr> <leader>6 buffer#Open('<Plug>AirlineSelectTab6')
nmap <expr> <leader>7 buffer#Open('<Plug>AirlineSelectTab7')
nmap <expr> <leader>8 buffer#Open('<Plug>AirlineSelectTab8')
nmap <expr> <leader>9 buffer#Open('<Plug>AirlineSelectTab9')

" Plug 'edkolev/tmuxline.vim'
let g:airline#extensions#tmuxline#enabled = 0
" let g:airline#extensions#tmuxline#color_template = 'insert'
let g:tmuxline_preset = {
            \   'a'    : 'Tmux',
            \   'b'    : 'Session: #S',
            \   'c'    : '',
            \   'win'  : '#I.#W#F',
            \   'cwin' : '#I.#W#F',
            \   'x'    : ['#(whoami)@#H', '%F %a', '#{cpu_fg_color}#{cpu_icon} #{cpu_percentage}'],
            \   'z'    : '%R',
            \   'options' : {'status-justify' : 'left', 'status-position' : 'top'}
            \}

scriptencoding utf-8
