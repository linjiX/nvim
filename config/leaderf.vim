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

let s:WindowHeight = 0.3
let s:PositionLine = float2nr(&lines * (1 - s:WindowHeight))
let s:PositionCol = SiderBarWidth() + 2

let g:Lf_WindowHeight = s:WindowHeight
let g:Lf_WindowPosition = 'popup'
let g:Lf_PopupHeight = s:WindowHeight
let g:Lf_PopupPosition = [s:PositionLine, s:PositionCol]
let g:Lf_StlSeparator = {'left': '', 'right': ''}
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ReverseOrder = 1
let g:Lf_DefaultMode = 'NameOnly'
let g:Lf_ShowHidden = 1
let g:Lf_CacheDirectory = $MY_CACHE_PATH
let g:Lf_IgnoreCurrentBufferName = 1

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
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0}

function s:NormalMap() abort
    let l:subcommands = [
                \   'File', 'Buffer', 'Mru', 'Tag', 'BufTag', 'Function', 'Line', 'History',
                \   'Help', 'Self', 'Colorscheme', 'Window', 'Filetype', 'Command', 'Gtags', 'Rg'
                \]
    let l:Lf_NormalMap = {'_': [
                \   ['<C-j>', 'j'],
                \   ['<C-k>', 'k'],
                \   ['<C-h>', '<NOP>'],
                \   ['<C-l>', '<NOP>'],
                \   ['<C-n>', 'j'],
                \   ['<C-p>', 'k']
                \]}

    for l:key in l:subcommands
        let l:short_key = l:key ==# 'Buffer' ? 'buf' : tolower(l:key[0]) . l:key[1:]
        let l:quit_command = printf(':exec g:Lf_py "%sExplManager.quit()"<CR>', l:short_key)
        let l:Lf_NormalMap[l:key] = [['<ESC>', l:quit_command]]
    endfor

    return l:Lf_NormalMap
endfunction

let g:Lf_NormalMap = s:NormalMap()
let g:Lf_CommandMap = {'<F5>': ['<C-l>']}
let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''

function s:MyLeaderf(bang, args) abort
    let l:bangcmd = a:bang ? '! ' : ' '
    let l:cmd = 'Leaderf'. l:bangcmd . a:args
    if !has('nvim')
        execute l:cmd
        return
    endif

    let l:screencol = screencol() - 6
    let l:screenrow = screenrow()
    let l:max_screenrow = float2nr(&lines * (1 - g:Lf_PopupHeight))
    if l:screenrow > l:max_screenrow
        let l:screenrow = l:max_screenrow
    endif

    let l:leaderf_config = {'g:Lf_PopupPosition': [l:screenrow, l:screencol]}
    let l:old_config = utility#SetConfig(l:leaderf_config)
    try
        execute l:cmd
    finally
        call utility#SetConfig(l:old_config)
    endtry
endfunction

command! -bang -nargs=+ -complete=customlist,leaderf#Any#parseArguments
            \ MyLeaderf call s:MyLeaderf(<bang>0, <q-args>)

nnoremap <expr><silent> <leader>ff utility#Open(":MyLeaderf file\<CR>")
nnoremap <expr><silent> <leader>fb utility#Open(":MyLeaderf buffer\<CR>")
nnoremap <expr><silent> <leader>fB utility#Open(":MyLeaderf buffer --all\<CR>")
nnoremap <expr><silent> <leader>fm utility#Open(":MyLeaderf mru --cwd\<CR>")
nnoremap <expr><silent> <leader>fM utility#Open(":MyLeaderf mru\<CR>")
nnoremap <expr><silent> <leader>ft utility#Open(":MyLeaderf bufTag\<CR>")
nnoremap <expr><silent> <leader>fT utility#Open(":MyLeaderf bufTag --all\<CR>")
nnoremap <expr><silent> <leader>fu utility#Open(":MyLeaderf function\<CR>")
nnoremap <expr><silent> <leader>fU utility#Open(":MyLeaderf function --all\<CR>")
nnoremap <expr><silent> <leader>fg utility#Open(":MyLeaderf gtags\<CR>")
nnoremap <expr><silent> <leader>fr utility#Open(":MyLeaderf rg\<CR>")
nnoremap <expr><silent> <leader>fR utility#Open(":MyLeaderf rg --cword\<CR>")
nnoremap <silent> <leader>fl :MyLeaderf line<CR>
nnoremap <silent> <leader>fL :MyLeaderf line --all<CR>
nnoremap <silent> <leader>fw :MyLeaderf window<CR>
nnoremap <silent> <leader>fe :MyLeaderf filetype<CR>
nnoremap <silent> <leader>fx :MyLeaderf command<CR>
nnoremap <silent> <leader>f: :MyLeaderf cmdHistory<CR>
nnoremap <silent> <leader>f/ :MyLeaderf searchHistory<CR>
nnoremap <silent> <leader>fs :MyLeaderf self<CR>
nnoremap <silent> <leader>fh :MyLeaderf help<CR>
nnoremap <silent> <leader>fc :MyLeaderf colorscheme<CR>
nnoremap <silent> <leader>fo :MyLeaderf --recall<CR>

nnoremap <silent> <leader>go :MyLeaderf! gtags --recall<CR>
nnoremap <silent> <leader>gc :MyLeaderf! gtags --update<CR>
nnoremap <silent> <leader>gC :MyLeaderf! gtags --remove<CR>
nnoremap <silent> <leader>gg :MyLeaderf! gtags --definition <C-r><C-w> --auto-jump <CR>
nnoremap <silent> <leader>gr :MyLeaderf! gtags --reference <C-r><C-w> --auto-jump <CR>
nnoremap <silent> <leader>gs :MyLeaderf! gtags --symbol <C-r><C-w> --auto-jump <CR>
nnoremap <silent> <leader>gt :MyLeaderf! gtags --grep <C-r><C-w> --auto-jump <CR>
nnoremap <silent> <leader>gi :MyLeaderf! gtags --grep <C-r>=expand("<cfile>:t")<CR> --auto-jump <CR>
nnoremap <silent> <leader>gI :MyLeaderf! gtags --grep <C-r>=fnameescape(expand("%:t"))<CR> --auto-jump <CR>

scriptencoding utf-8
