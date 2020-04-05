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
    PlugInstall --sync
    source $MYVIMRC
    execute 'CocInstall -sync '. join(g:coc_global_extensions)
    while !empty(utility#TerminalList())
        sleep 1
    endwhile
    quitall
endfunction

function setup#AutoInstallation() abort
    let g:auto_installation = 1
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    silent !mkdir -p ~/.config
    silent !ln -sf ~/.vim ~/.config/nvim
    silent !ln -sf ~/.vim/vimrc ~/.config/nvim/init.vim
    augroup mySetup
        autocmd!
        autocmd VimEnter * call s:AutoCmdPlugInstall()
    augroup end
endfunction
