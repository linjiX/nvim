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
    let g:plug_window = 'buffer'
    let g:coc_channel_timeout = 3600
    PlugInstall --sync
    while !empty(terminal#ActiveList())
        sleep 1
    endwhile
    execute 'CocInstall -sync '. join(g:coc_global_extensions)
    quitall
endfunction

function setup#AutoInstallation() abort
    let g:auto_installation = 1
    let $MY_CONFIG = $HOME .'/.config'
    call system('curl -fLo $MY_PLUG_VIM --create-dirs '.
                \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    call mkdir($MY_CONFIG, 'p')
    call system('ln -sf $VIM_HOME $MY_CONFIG/nvim')
    call system('ln -sf $VIM_HOME/vimrc $MY_CONFIG/nvim/init.vim')
    augroup mySetup
        autocmd!
        autocmd VimEnter * call s:AutoCmdPlugInstall()
    augroup end
endfunction
