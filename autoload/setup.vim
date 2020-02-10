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

function s:HasTermianl() abort
    let l:bufnrs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    let l:bufnrs = filter(l:bufnrs, 'getbufvar(v:val, "&buftype") ==# "terminal"')
    return !empty(l:bufnrs)
endfunction

function s:AutoCmdPlugInstall() abort
    let g:plug_window = 'buffer'
    PlugInstall --sync
    source $MYVIMRC
    CocInstall -sync
                \ coc-word
                \ coc-highlight
                \ coc-snippets
                \ coc-json
                \ coc-python
                \ coc-vimlsp
                \ coc-phpls
                \ coc-translator
                \ coc-explorer
                \ coc-yank
                " \ coc-xml
    if has('macunix')
        CocInstall -sync coc-imselect
    endif
    while s:HasTermianl()
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
