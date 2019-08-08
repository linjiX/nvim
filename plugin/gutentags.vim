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

let s:vim_tags = expand('~/.cache/tags')
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_modules = ['gtags_cscope']
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_project_root = ['.root']
let g:gutentags_exclude_filetypes = [
            \ '', 'gitrebase', 'conf', 'diff', 'Dockerfile', 'text', 'proto',
            \ 'tags', 'python', 'bzl', 'vim', 'markdown', 'yaml', 'xml', 'json', 'lua', 'sh'
            \ ]
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_auto_add_gtags_cscope = 1
" let g:gutentags_ctags_extra_args = [
            " \ '--c++-kinds=+plxcdefgmnstuv',
            " \ '--c-kinds=+plxcdefgmnstuv',
            " \ '--fields=+iaS',
            " \ '--extra=+q'
            " \ ]
let g:gutentags_file_list_command = {
            \ 'markers': {
            \     '.git': 'git ls-files',
            \     '.root': 'find -type f',
            \     },
            \ }

" let g:gutentags_trace = 1
let g:gutentags_plus_nomap = 1

nnoremap <leader>g<Space> :GscopeFind 
nnoremap <silent> <leader>gs :GscopeFind s <C-r><C-w><CR>
nnoremap <silent> <leader>gg :GscopeFind g <C-r><C-w><CR>
nnoremap <silent> <leader>gc :GscopeFind c <C-r><C-w><CR>
nnoremap <silent> <leader>gt :GscopeFind t <C-r><C-w><CR>
nnoremap <silent> <leader>ge :GscopeFind e <C-r><C-w><CR>
nnoremap <silent> <leader>gf :GscopeFind f <C-r>=expand("<cfile>:t")<CR><CR>
nnoremap <silent> <leader>gi :GscopeFind i <C-r>=expand("<cfile>:t")<CR><CR>
nnoremap <silent> <leader>gI :GscopeFind i <C-r>=fnameescape(expand('%:t'))<CR><CR>
nnoremap <silent> <leader>gd :GscopeFind d <C-r><C-w><CR>
nnoremap <silent> <leader>ga :GscopeFind a <C-r><C-w><CR>
