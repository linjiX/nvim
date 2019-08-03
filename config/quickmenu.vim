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

let g:quickmenu_options = "HL"
let g:quickmenu_padding_right = 25

call g:quickmenu#append("Startify", "Startify", "")

call g:quickmenu#append("# Interesting", "")
call g:quickmenu#append("Rainbow Toggle <F2>", "RainbowToggle", "")
call g:quickmenu#append("Limelight Toggle <F3>", "Limelight!!", "")
call g:quickmenu#append("WhichKey <F4>", "WhichKey ''", "")

call g:quickmenu#append("# System Toggle", "")
call g:quickmenu#append("Turn Mouse %{&mouse == '' ? 'on':'off'} <F5>", "call MouseToggle()", "")
call g:quickmenu#append("Turn Sidebar %{&number? 'on':'off'} <F6>", "call SidebarToggle()", "")
call g:quickmenu#append("Turn Spell %{&spell? 'off':'on'} <F7>", "set spell!", "")
call g:quickmenu#append("Turn Paste %{&paste? 'off':'on'} <F8>", "set paste!", "")

function MouseToggle()
    if &mouse == ''
        set mouse=a
        echo "Mouse On"
    else
        set mouse=
        echo "Mouse Off"
    endif
endfunction

function SidebarToggle()
    set number!
    IndentLinesToggle
    if &number
        set signcolumn=auto
        echo "Sidebar On"
    else
        set signcolumn=no
        echo "Sidebar Off"
    endif
endfunction

augroup myQuickMenu
    autocmd!
    autocmd FileType quickmenu nnoremap <silent><buffer> <leader>q :call quickmenu#toggle(0)<CR>
augroup END

nnoremap <silent><F12> :call quickmenu#toggle(0)<CR>

nnoremap <silent> <F5> :call MouseToggle()<CR>
nnoremap <silent> <F6> :call SidebarToggle()<CR>
nnoremap <F7> :set spell!<CR>
set pastetoggle=<F8>
