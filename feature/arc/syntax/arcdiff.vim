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

if has('spell')
    syntax spell toplevel
endif

syntax match arccommitFirstLine "\%^[^#].*" nextgroup=arccommitBlank skipnl
syntax match arccommitBlank "^[^#].*" contained contains=@Spell
syntax match arccommitTitle "\v^.{0,72}" contained containedin=arccommitFirstLine
            \ nextgroup=arccommitOverflow contains=@Spell
syntax match arccommitOverflow ".*" contained contains=@Spell
syntax match arccommitItem "\v^(\u\l+\s*)+:"
syntax match arccommitComment "^#.*"

highlight default link arccommitTitle Keyword
highlight default link arccommitBlank Error
highlight default link arccommitItem Special
highlight default link arccommitComment Comment
