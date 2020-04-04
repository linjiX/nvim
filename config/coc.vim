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

" Plug 'Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'floating'

" Plug 'neoclide/coc.nvim'
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

function! s:ShowDocumentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

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

let s:coc_lsp = {
            \   'python': 'coc-python',
            \   'json': 'coc-json',
            \   'vim': 'coc-vimlsp',
            \   'xml': 'coc-xml',
            \   'c': 'languageserver.ccls',
            \   'cpp': 'languageserver.ccls',
            \   'sh': 'languageserver.bash',
            \   'Dockerfile': 'languageserver.dockerfile',
            \}
function s:ToggleLSP() abort
    if !has_key(s:coc_lsp, &filetype)
        return
    endif
    let l:name = s:coc_lsp[&filetype]

    if l:name =~# '\v^coc-'
        let l:list = CocAction('extensionStats')
        for l:item in l:list
            if l:item.id ==# l:name
                let l:state = l:item.state
            endif
        endfor
        if l:state ==# 'activated'
            echo 'Disable '. l:name
            call CocAction('deactivateExtension', l:name)
        else
            echo 'Enable '. l:name
            call CocAction('reloadExtension', l:name)
        endif
    else
        echo 'Toggle '. l:name
        call CocAction('toggleService', l:name)
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
            \ pumvisible() ? "\<C-n>"
            \              : coc#refresh()
inoremap <silent><expr> <C-k>
            \ pumvisible() ? "\<C-p>"
            \              : "\<C-k>"
imap <silent><expr> <TAB>
            \ pumvisible() ? coc#expandable() ? "\<C-e><Plug>(coc-snippets-expand)"
            \                                 : coc#_select_confirm()
            \              : coc#expandable() ? "<Plug>(coc-snippets-expand)"
            \                                 : <SID>CheckBackSpace() ? "\<TAB>"
            \                                                         : coc#refresh()
inoremap <silent><expr> <S-TAB> coc#refresh()

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>ShowDocumentation()<CR>

nmap [rc :CocEnable<CR>
nmap ]rc :CocDisable<CR>
nmap <expr> yrc <SID>CocToggle()
nnoremap <silent> yrC :call <SID>CocRestart()<CR>
nnoremap <silent> yrl :call <SID>ToggleLSP()<CR>

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

nnoremap <leader>lu :CocUpdate<CR>
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
nnoremap <silent> <leader>lx :CocList commands<CR>

" coc-git
nmap <leader>gp <Plug>(coc-git-chunkinfo)
nmap <leader>gM <Plug>(coc-git-commit)
nnoremap <silent> <leader>gy :CocCommand git.copyUrl<CR>
nnoremap <silent> <leader>gu :CocCommand git.chunkUndo<CR>
nnoremap <silent> <leader>ga :CocCommand git.chunkStage<CR>
nnoremap <silent> <leader>gd :CocCommand git.diffCached<CR>
nnoremap <silent> <leader>gb :CocCommand git.browserOpen<CR>
nnoremap <silent> <leader>gf :CocCommand git.foldUnchanged<CR>

nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)
nnoremap <silent> yrg :CocCommand git.toggleGutters<CR>

omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

" coc-translator
nmap <silent> <leader>tp <Plug>(coc-translator-p)
xmap <silent> <leader>tp <Plug>(coc-translator-pv)
nmap <silent> <leader>te <Plug>(coc-translator-e)
xmap <silent> <leader>te <Plug>(coc-translator-ev)
nmap <silent> <leader>tr <Plug>(coc-translator-r)
xmap <silent> <leader>tr <Plug>(coc-translator-rv)

" coc-explorer
nnoremap <silent> <leader>w :call workspace#Toggle()<CR>
nnoremap <silent> <leader>W :call workspace#Reveal()<CR>

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
