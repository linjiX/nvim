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

nnoremap <expr><silent> <C-p> buffer#Open(":Leaderf file\<CR>")
nnoremap <expr><silent> <leader>ff buffer#Open(":Leaderf file\<CR>")
nnoremap <expr><silent> <leader>fb buffer#Open(":Leaderf buffer\<CR>")
nnoremap <expr><silent> <leader>fB buffer#Open(":Leaderf buffer --all\<CR>")
nnoremap <expr><silent> <leader>fm buffer#Open(":Leaderf mru --cwd\<CR>")
nnoremap <expr><silent> <leader>fM buffer#Open(":Leaderf mru\<CR>")
nnoremap <expr><silent> <leader>ft buffer#Open(":Leaderf bufTag\<CR>")
nnoremap <expr><silent> <leader>fT buffer#Open(":Leaderf bufTag --all\<CR>")
nnoremap <expr><silent> <leader>fu buffer#Open(":Leaderf function\<CR>")
nnoremap <expr><silent> <leader>fU buffer#Open(":Leaderf function --all\<CR>")
nnoremap <expr><silent> <leader>fr buffer#Open(":Leaderf rg\<CR>")
nnoremap <expr><silent> <leader>fR buffer#Open(":Leaderf rg --recall\<CR>")
nnoremap <silent> <leader>fl :Leaderf line<CR>
nnoremap <silent> <leader>fL :Leaderf line --all<CR>
nnoremap <silent> <leader>f: :Leaderf cmdHistory<CR>
nnoremap <silent> <leader>f/ :Leaderf searchHistory<CR>
nnoremap <silent> <leader>fs :Leaderf self<CR>
nnoremap <silent> <leader>fh :Leaderf help<CR>
nnoremap <silent> <leader>fc :Leaderf colorscheme<CR>
