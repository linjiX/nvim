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
scriptencoding utf-8

let g:Lf_WindowHeight = 0.3
let g:Lf_WindowPosition = 'popup'
let g:Lf_PopupHeight = 0.3
let g:Lf_StlSeparator = {'left': '', 'right': ''}
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ReverseOrder = 1
let g:Lf_DefaultMode = 'NameOnly'
let g:Lf_ShowHidden = 1
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
let g:Lf_Gtagslabel = 'native-pygments'

let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewHorizontalPosition = 'right'

let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''

function s:MyLeaderf(bang, args) abort
    let l:screencol = screencol() - 6
    let l:screenrow = screenrow() - 1
    let l:max_screenrow = float2nr(&lines * (1 - g:Lf_PopupHeight))
    if l:screenrow > l:max_screenrow
        let l:screenrow = l:max_screenrow
    endif

    let l:Lf_PopupPosition_User = get(g:, 'Lf_PopupPosition', [0, 0])
    try
        let g:Lf_PopupPosition = [l:screenrow, l:screencol]
        let l:bangcmd = a:bang ? '! ' : ' '
        execute 'Leaderf'. l:bangcmd . a:args
    finally
        let g:Lf_PopupPosition = l:Lf_PopupPosition_User
    endtry
endfunction

command! -bang -nargs=+ -complete=customlist,leaderf#Any#parseArguments
            \ MyLeaderf call s:MyLeaderf(<bang>0, <q-args>)

nnoremap <expr><silent> <leader>ff buffer#Open(":MyLeaderf file\<CR>")
nnoremap <expr><silent> <leader>fb buffer#Open(":MyLeaderf buffer\<CR>")
nnoremap <expr><silent> <leader>fB buffer#Open(":MyLeaderf buffer --all\<CR>")
nnoremap <expr><silent> <leader>fm buffer#Open(":MyLeaderf mru --cwd\<CR>")
nnoremap <expr><silent> <leader>fM buffer#Open(":MyLeaderf mru\<CR>")
nnoremap <expr><silent> <leader>ft buffer#Open(":MyLeaderf bufTag\<CR>")
nnoremap <expr><silent> <leader>fT buffer#Open(":MyLeaderf bufTag --all\<CR>")
nnoremap <expr><silent> <leader>fu buffer#Open(":MyLeaderf function\<CR>")
nnoremap <expr><silent> <leader>fU buffer#Open(":MyLeaderf function --all\<CR>")
nnoremap <expr><silent> <leader>fg buffer#Open(":MyLeaderf gtags\<CR>")
nnoremap <expr><silent> <leader>fr buffer#Open(":MyLeaderf rg\<CR>")
nnoremap <expr><silent> <leader>fR buffer#Open(":MyLeaderf rg --recall\<CR>")
nnoremap <silent> <leader>fl :MyLeaderf line<CR>
nnoremap <silent> <leader>fL :MyLeaderf line --all<CR>
nnoremap <silent> <leader>f: :MyLeaderf cmdHistory<CR>
nnoremap <silent> <leader>f/ :MyLeaderf searchHistory<CR>
nnoremap <silent> <leader>fs :MyLeaderf self<CR>
nnoremap <silent> <leader>fh :MyLeaderf help<CR>
nnoremap <silent> <leader>fc :MyLeaderf colorscheme<CR>

nnoremap <silent> <leader>gg :MyLeaderf! gtags --definition <C-r><C-w> --auto-jump <CR>
nnoremap <silent> <leader>gr :MyLeaderf! gtags --reference <C-r><C-w> --auto-jump <CR>
nnoremap <silent> <leader>gs :MyLeaderf! gtags --symbol <C-r><C-w> --auto-jump <CR>
nnoremap <silent> <leader>gt :MyLeaderf! gtags --grep <C-r><C-w> --auto-jump <CR>
nnoremap <silent> <leader>gi :MyLeaderf! gtags --grep <C-r>=expand("<cfile>:t")<CR> --auto-jump <CR>
nnoremap <silent> <leader>gI :MyLeaderf! gtags --grep <C-r>=fnameescape(expand("%:t"))<CR> --auto-jump <CR>
