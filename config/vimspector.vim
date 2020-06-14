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

let $VIMSPECTOR_CONFIG = $VIM_HOME .'/.vimspector.json'

let s:vimspector_settings = {
            \   'python': 'Python: Launch',
            \}

function s:LinkConfig() abort
    let l:root = FindRootDirectory()
    if empty(l:root)
        let l:root = expand('%:p:h')
    endif
    let l:config_path = l:root .'/.vimspector.json'

    if filereadable(l:config_path)
        return
    endif

    call system('ln -s $VIMSPECTOR_CONFIG '. l:config_path)
endfunction

function s:Launch() abort
    try
        let l:setting = s:vimspector_settings[&filetype]
    catch /^Vim\%((\a\+)\)\=:E716/
        echo &filetype .' DAP is not registered'
        return
    endtry

    call s:LinkConfig()
    if !exists('*vimspector#LaunchWithSettings')
        call plug#load('vimspector')
    endif
    call vimspector#LaunchWithSettings({'configuration': l:setting})
endfunction

nmap <silent> <leader>ds :call <SID>Launch()<CR>
nmap <silent> <leader>df <Plug>VimspectorContinue
nmap <silent> <leader>dq <Plug>VimspectorStop
nmap <silent> <leader>dr <Plug>VimspectorRestart
nmap <silent> <leader>dp <Plug>VimspectorPause
nmap <silent> <leader>dd <Plug>VimspectorToggleBreakpoint
nmap <silent> <leader>dD <Plug>VimspectorAddFunctionBreakpoint
nmap <silent> <leader>dj <Plug>VimspectorStepOver
nmap <silent> <leader>di <Plug>VimspectorStepInto
nmap <silent> <leader>do <Plug>VimspectorStepOut

nnoremap <silent> <leader>dc :call vimspector#ClearBreakpoints()<CR>
nnoremap <silent> <leader>dl :call vimspector#ListBreakpoints()<CR>
