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

let g:which_key_use_floating_win = 1
let g:which_key_map = {}
let g:which_key_map.c = {'name':'+prefix TComment && Conflict'}
let g:which_key_map.d = {'name':'+prefix Vimspector'}
let g:which_key_map.e = {'name':'+prefix Slime'}
let g:which_key_map.f = {'name':'+prefix LeaderF'}
let g:which_key_map.g = {'name':'+prefix Gtags && GitGutter'}
let g:which_key_map.j = {'name':'+prefix CocJump && Jq'}
let g:which_key_map.l = {'name':'+prefix Coc'}
let g:which_key_map.m = {'name':'+prefix Markdown'}
let g:which_key_map.s = {'name':'+prefix CtrlSF'}
let g:which_key_map.t = {'name':'+prefix Translator'}
let g:which_key_map.v = {'name':'+prefix Plug'}

call which_key#register('<Space>', 'g:which_key_map')

nnoremap <silent> <leader> :<C-u>WhichKey '<Space>'<CR>
xnoremap <silent> <leader> :<C-u>WhichKeyVisual '<Space>'<CR>
