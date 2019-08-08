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

"let g:ycm_global_ycm_extra_conf = '~/.vim/plug/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-j>'
let g:ycm_max_num_candidates = 10
let g:ycm_max_num_identifier_candidates = 6
let g:ycm_error_symbol = 'E'
let g:ycm_warning_symbol = 'W'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 1

let g:ycm_use_clangd = 0
" let g:ycm_clangd_binary_path = exepath('clangd-8')
" let g:ycm_clangd_uses_ycmd_caching = 0

nnoremap <silent> <leader>j :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>t :YcmCompleter GetType<CR>
nnoremap <silent> <leader>d :YcmDiags<CR>
nnoremap <silent> <leader>x :YcmCompleter FixIt<CR>
