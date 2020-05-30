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

function s:AutoCmdPlugInstall() abort
    let g:coc_channel_timeout = 3600
    let l:coc_global_extensions = join(g:coc_global_extensions)
    unlet g:coc_global_extensions

    let g:plug_window = 'buffer'
    PlugInstall --sync
    execute 'CocInstall -sync '. l:coc_global_extensions
    while !empty(terminal#ActiveList())
        sleep 1
    endwhile
    quitall
endfunction

function setup#AutoInstallation() abort
    let g:auto_installation = 1
    call system('curl -fLo $MY_PLUG_VIM --create-dirs '.
                \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    augroup mySetup
        autocmd!
        autocmd VimEnter * call s:AutoCmdPlugInstall()
    augroup end
endfunction
