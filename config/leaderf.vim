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

let g:Lf_WindowHeight = 0.3
let g:Lf_StlSeparator = {'left': '', 'right': ''}
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ReverseOrder = 1
let g:Lf_DefaultMode = 'NameOnly'

let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''

nnoremap <expr><silent> <C-p> BufferCmd(":Leaderf file\<CR>")
nnoremap <expr><silent> <leader>ff BufferCmd(":Leaderf file\<CR>")
nnoremap <expr><silent> <leader>fb BufferCmd(":Leaderf buffer\<CR>")
nnoremap <expr><silent> <leader>fB BufferCmd(":Leaderf buffer --all\<CR>")
nnoremap <expr><silent> <leader>fm BufferCmd(":Leaderf mru --cwd\<CR>")
nnoremap <expr><silent> <leader>fM BufferCmd(":Leaderf mru\<CR>")
nnoremap <expr><silent> <leader>ft BufferCmd(":Leaderf bufTag\<CR>")
nnoremap <expr><silent> <leader>fT BufferCmd(":Leaderf bufTag --all\<CR>")
nnoremap <expr><silent> <leader>fu BufferCmd(":Leaderf function\<CR>")
nnoremap <expr><silent> <leader>fU BufferCmd(":Leaderf function --all\<CR>")
nnoremap <silent> <leader>fl :Leaderf line<CR>
nnoremap <silent> <leader>fL :Leaderf line --all<CR>
nnoremap <silent> <leader>f: :Leaderf cmdHistory<CR>
nnoremap <silent> <leader>f/ :Leaderf searchHistory<CR>
nnoremap <silent> <leader>fs :Leaderf self<CR>
nnoremap <silent> <leader>fh :Leaderf help<CR>
nnoremap <silent> <leader>fc :Leaderf colorscheme<CR>
nnoremap <silent> <leader>fr :Leaderf rg<CR>
nnoremap <silent> <leader>fR :Leaderf rg --recall<CR>
