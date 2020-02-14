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

let g:which_key_use_floating_win = 1
let g:which_key_map = {
            \   '`' :'BufKillAlt',
            \   'i' :'BufKillForward',
            \   'o' :'BufKillBack',
            \   'q' :'BufKillBw',
            \   'Q' :'BufKillBd',
            \   'u' :'BufKillUndo',
            \}
let g:which_key_map.c = {'name':'+prefix NERDCommenter'}
let g:which_key_map.e = {'name':'+prefix Slime'}
let g:which_key_map.f = {'name':'+prefix LeaderF'}
let g:which_key_map.g = {'name':'+prefix Gtags && GitGutter'}
let g:which_key_map.l = {'name':'+prefix Coc'}
let g:which_key_map.m = {'name':'+prefix Markdown'}
let g:which_key_map.s = {'name':'+prefix CtrlSF'}
let g:which_key_map.v = {'name':'+prefix Plug'}
let g:which_key_map.z = {'name':'+prefix fzf'}

call which_key#register('<Space>', 'g:which_key_map')

" nnoremap <F4> :WhichKey ''<CR>
" vnoremap <F4> :WhichKeyVisual ''<CR>
nnoremap <silent> <leader> :<C-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<C-u>WhichKeyVisual '<Space>'<CR>
