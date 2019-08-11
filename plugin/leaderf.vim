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
" let g:Lf_RememberLastSearch = 1

if executable('gtags')
    let g:Lf_GtagsAutoGenerate = 1
else
    let g:Lf_GtagsAutoGenerate = 0
endif

let g:Lf_GtagsSource = 2
let g:Lf_GtagsfilesCmd = {'.git': 'git ls-files -c -o --exclude-standard'}
let g:Lf_GtagsSkipUnreadable = 1
let g:Lf_GtagsSkipSymlink = 'a'
let g:Lf_Gtagslabel = "native-pygments"

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
nnoremap <expr><silent> <leader>fg BufferCmd(":Leaderf gtags\<CR>")
nnoremap <silent> <leader>fl :Leaderf line<CR>
nnoremap <silent> <leader>fL :Leaderf line --all<CR>
nnoremap <silent> <leader>f: :Leaderf cmdHistory<CR>
nnoremap <silent> <leader>f/ :Leaderf searchHistory<CR>
nnoremap <silent> <leader>fs :Leaderf self<CR>
nnoremap <silent> <leader>fh :Leaderf help<CR>
nnoremap <silent> <leader>fc :Leaderf colorscheme<CR>
nnoremap <silent> <leader>fr :Leaderf rg<CR>
nnoremap <silent> <leader>fR :Leaderf rg --recall<CR>

nnoremap <silent> <leader>gg :Leaderf! gtags -d <C-r><C-w><CR>
nnoremap <silent> <leader>gr :Leaderf! gtags -r <C-r><C-w><CR>
nnoremap <silent> <leader>gs :Leaderf! gtags -s <C-r><C-w><CR>
nnoremap <silent> <leader>gt :Leaderf! gtags -g <C-r><C-w><CR>
nnoremap <silent> <leader>gi :Leaderf! gtags -g <C-r>=expand("<cfile>:t")<CR><CR>
nnoremap <silent> <leader>gI :Leaderf! gtags -g <C-r>=fnameescape(expand("%:t"))<CR><CR>