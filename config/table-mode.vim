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

let g:table_mode_map_prefix = '<leader>m'
let g:table_mode_toggle_map = 'm'
let g:table_mode_realign_map = '<Leader>ma'
let g:table_mode_delete_row_map = '<leader>md'
let g:table_mode_delete_column_map = '<leader>mc'
let g:table_mode_add_formula_map = '<leader>mf'
let g:table_mode_eval_formula_map = '<leader>me'
let g:table_mode_echo_cell_map = '<leader>m?'
let g:table_mode_sort_map = '<leader>ms'
let g:table_mode_tableize_map = '<leader>mt'
let g:table_mode_tableize_d_map = '<leader>mT'

augroup  myTableMode
    autocmd!
    autocmd FileType markdown nnoremap <silent><buffer> <leader>mm :TableModeToggle<CR>
augroup END
