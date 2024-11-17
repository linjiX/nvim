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

" Plug 'Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'floating'

" Plug 'neoclide/coc.nvim'
let g:coc_config_home = $VIM_HOME
let g:coc_enable_locationlist = 0

let g:coc_snippet_next = '<C-l>'
let g:coc_snippet_prev = '<C-h>'

function! s:CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc-xml
let s:java_home =
            \ has('macunix') ? '/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
            \                : '/usr/lib/jvm/java-8-openjdk-amd64'
call coc#config('xml.java.home', s:java_home)

function s:CocRestart() abort
    if workspace#Disable()
        autocmd myCoc User CocNvimInit ++once call workspace#Toggle()
    endif
    CocRestart
endfunction

function s:CocToggle() abort
    return g:coc_enabled ? ":CocDisable\<CR>"
                \        : ":CocEnable\<CR>"
endfunction

function s:ToggleService(name) abort
    call CocAction('toggleService', a:name)
    echo 'Toggle '. a:name
endfunction

function s:RestartExtension(name) abort
    call CocAction('reloadExtension', a:name)
    echo 'Restart '. a:name
endfunction

function s:EnableExtension(name) abort
    call CocAction('reloadExtension', a:name)
    echo 'Enable '. a:name
endfunction

function s:DisableExtension(name) abort
    call CocAction('deactivateExtension', a:name)
    echo 'Disable '. a:name
endfunction

function s:ToggleExtension(name) abort
    let l:list = CocAction('extensionStats')
    for l:item in l:list
        if l:item.id ==# a:name
            let l:state = l:item.state
            break
        endif
    endfor
    if !exists('l:state')
        call utility#LogWarning('No coc extension: '. a:name)
        return
    endif
    if l:state ==# 'activated'
        call s:DisableExtension(a:name)
    else
        call s:EnableExtension(a:name)
    endif
endfunction

let s:coc_lsp = {
            \   'python': 'coc-pyright',
            \   'json': 'coc-json',
            \   'vim': 'coc-vimlsp',
            \   'xml': 'coc-xml',
            \   'yaml': 'coc-yaml',
            \   'c': 'languageserver.ccls',
            \   'cpp': 'languageserver.ccls',
            \   'sh': 'languageserver.bash',
            \   'Dockerfile': 'languageserver.dockerfile',
            \   'javascript': 'coc-tsserver',
            \   'typescript': 'coc-tsserver',
            \   'vue': 'coc-vetur',
            \   'html': 'coc-html',
            \}

let s:coc_action = {
            \   'toggle': function('s:ToggleExtension'),
            \   'enable': function('s:EnableExtension'),
            \   'disable': function('s:DisableExtension'),
            \   'restart': function('s:RestartExtension'),
            \}

function s:LSPAction(action) abort
    try
        let l:name = s:coc_lsp[&filetype]
    catch /^Vim\%((\a\+)\)\=:E716/
        echo &filetype .' LSP is not registered'
        return
    endtry

    if l:name =~# '\v^coc-'
        call s:coc_action[a:action](l:name)
    else
        call s:ToggleService(name)
    endif
endfunction

function s:AutoCmdCocInfo() abort
    if &buftype ==# 'nofile'
        setlocal nobuflisted
        setlocal bufhidden=wipe
    endif
endfunction

augroup myCoc
    autocmd!
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent! call CocActionAsync('highlight')
    " Disable locationlist auto preview
    autocmd User CocLocationsChange CocList --normal location
    autocmd User CocNvimInit let g:coc_init = 1
    autocmd FileType coc-explorer nnoremap <buffer> <leader> <Nop>
    autocmd FileType log call s:AutoCmdCocInfo()
    autocmd FileType c,cpp call s:AutoCmdCcls()
augroup END

inoremap <silent><expr> <C-j>
            \ coc#pum#visible() ? coc#pum#next(1)
            \                   : coc#refresh()
inoremap <silent><expr> <C-k>
            \ coc#pum#visible() ? coc#pum#prev(1)
            \                   : "\<C-k>"
imap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#_select_confirm()
            \                   : coc#expandable() ? "<Plug>(coc-snippets-expand)"
            \                                      : <SID>CheckBackSpace() ? "\<TAB>"
            \                                                              : coc#refresh()

inoremap <silent><expr> <S-TAB> coc#refresh()

nnoremap <silent><expr> K
            \ index(['vim','help'], &filetype) != -1 ? 'K'
            \                                        : ":call CocAction('doHover')\<CR>"

nmap [rc :CocEnable<CR>
nmap ]rc :CocDisable<CR>
nmap <expr> yrc <SID>CocToggle()
nnoremap <silent> yrC :call <SID>CocRestart()<CR>

nnoremap <silent> [rl :call <SID>LSPAction('enable')<CR>
nnoremap <silent> ]rl :call <SID>LSPAction('disable')<CR>
nnoremap <silent> yrl :call <SID>LSPAction('toggle')<CR>
nnoremap <silent> yrL :call <SID>LSPAction('restart')<CR>

nmap <silent> <leader>jj <Plug>(coc-definition)
nmap <silent> <leader>jd <Plug>(coc-declaration)
nmap <silent> <leader>ji <Plug>(coc-implementation)
nmap <silent> <leader>jr <Plug>(coc-references)
nmap <silent> <leader>jt <Plug>(coc-type-definition)
nmap <silent> <leader>x <Plug>(coc-fix-current)

nmap <silent> <leader>A <Plug>(coc-format)
xmap <silent> <leader>A <Plug>(coc-format-selected)
nmap <silent> g= <Plug>(coc-format-selected)
" nmap <silent> g== <Plug>(coc-format)
" xmap <silent> g= <Plug>(coc-format-selected)

nmap <silent> ]j <Plug>(coc-diagnostic-next)
nmap <silent> [j <Plug>(coc-diagnostic-prev)

nnoremap <silent> <leader>tt :call CocAction('doHover')<CR>

nnoremap <silent> <leader>lu :CocUpdate<CR>
nmap <silent> <leader>lr <Plug>(coc-rename)
nmap <silent> <leader>lR <Plug>(coc-refactor)
nmap <silent> <leader>lh <Plug>(coc-float-hide)

" CocList
nnoremap <silent> <leader>ll :CocList<CR>
nnoremap <silent> <leader>lo :CocListResume<CR>
nnoremap <silent> <leader>ld :CocList --normal diagnostics<CR>
nnoremap <silent> <leader>le :CocList --normal extensions<CR>
nnoremap <silent> <leader>lp :CocList --normal yank<CR>
nnoremap <silent> <leader>lt :CocList --normal translation<CR>
nnoremap <silent> <leader>ls :CocList --interactive symbols<CR>
nnoremap <silent> <leader>lc :CocList commands<CR>

" coc-translator
nmap <silent> <leader>tp <Plug>(coc-translator-p)
xmap <silent> <leader>tp <Plug>(coc-translator-pv)
nmap <silent> <leader>te <Plug>(coc-translator-e)
xmap <silent> <leader>te <Plug>(coc-translator-ev)
nmap <silent> <leader>tr <Plug>(coc-translator-r)
xmap <silent> <leader>tr <Plug>(coc-translator-rv)

" coc-explorer
let g:coc_explorer_global_presets = {
            \   'floating': {
            \       'position': 'floating',
            \       'floating-position': 'center',
            \       'file-child-template': '[git | 2] [selection | clip | 1] [indent][icon | 1] '.
            \                              '[diagnosticError & 1][filename][modified][readonly] '.
            \                              '[linkIcon & 1][link growRight 1 omitCenter 5]',
            \   }
            \}

nnoremap <silent> <leader>w :call workspace#Toggle()<CR>
nnoremap <silent> <leader>W :call workspace#Reveal()<CR>
nnoremap <silent> <leader>lf :CocCommand explorer
            \ --preset=floating
            \ --floating-width=<C-r>=SiderBarWidth()+10<CR>
            \ <CR>
nnoremap <silent> <leader>lF :CocCommand explorer
            \ --preset=floating
            \ --floating-width=<C-r>=SiderBarWidth()+10<CR>
            \ --reveal=<C-r>=fnameescape(expand('%:p'))<CR>
            \ <CR>

" ccls
function s:AutoCmdCcls() abort
    nnoremap <silent><buffer> <leader>zk
                \ :call CocLocations('ccls', '$ccls/navigate', {'direction':'U'})<CR>
    nnoremap <silent><buffer> <leader>zj
                \ :call CocLocations('ccls', '$ccls/navigate', {'direction':'D'})<CR>
    nnoremap <silent><buffer> <leader>zl
                \ :call CocLocations('ccls', '$ccls/navigate', {'direction':'L'})<CR>
    nnoremap <silent><buffer> <leader>zh
                \ :call CocLocations('ccls', '$ccls/navigate', {'direction':'R'})<CR>

    nnoremap <silent><buffer> <leader>zb
                \ :call CocLocations('ccls', '$ccls/inheritance')<CR>
    nnoremap <silent><buffer> <leader>zB
                \ :call CocLocations('ccls', '$ccls/inheritance', {'levels':3})<CR>
    nnoremap <silent><buffer> <leader>zd
                \ :call CocLocations('ccls', '$ccls/inheritance', {'derived': v:true})<CR>
    nnoremap <silent><buffer> <leader>zD
                \ :call CocLocations('ccls', '$ccls/inheritance',
                \                    {'derived': v:true, 'levels': 3})<CR>

    nnoremap <silent><buffer> <leader>zc
                \ :call CocLocations('ccls', '$ccls/call')<CR>
    nnoremap <silent><buffer> <leader>zC
                \ :call CocLocations('ccls', '$ccls/call', {'callee': v:true})<CR>

    nnoremap <silent><buffer> <leader>zm
                \ :call CocLocations('ccls', '$ccls/member')<CR>
    nnoremap <silent><buffer> <leader>zM
                \ :call CocLocations('ccls', '$ccls/member', {'kind': 3})<CR>
    nnoremap <silent><buffer> <leader>zt
                \ :call CocLocations('ccls', '$ccls/member', {'kind': 2})<CR>

    nnoremap <silent><buffer> <leader>zv
                \ :call CocLocations('ccls', '$ccls/vars', {'kind': 1})<CR>
    nnoremap <silent><buffer> <leader>zV
                \ :call CocLocations('ccls', '$ccls/vars')<CR>
endfunction
