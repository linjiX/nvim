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
    execute 'CocInstall -sync '. join(g:coc_global_extensions)
    while !empty(terminal#ActiveList())
        sleep 1
    endwhile
    quitall
endfunction

function setup#AutoInstallation() abort
    let g:auto_installation = 1
    call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs '.
                \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    call mkdir('~/.config', 'p')
    call system('ln -sf ~/.vim ~/.config/nvim')
    call system('ln -sf ~/.vim/vimrc ~/.config/nvim/init.vim')
    augroup mySetup
        autocmd!
        autocmd VimEnter * call s:AutoCmdPlugInstall()
    augroup end
endfunction
