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

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

let g:formatdef_clang_format = "'clang-format ".
            \                  "-lines='.a:firstline.':'.a:lastline.' ".
            \                  "--assume-filename=\"'.expand('%:p').'\" ".
            \                  "-style=file'"
let g:formatters_cpp = ['clang_format']
let g:formatters_proto = ['clang_format']

let g:formatdef_buildifier = "'buildifier'"
let g:formatters_bzl = ['buildifier']

let g:formatdef_isort = "'isort -w 100 -'"
let g:formatdef_docformatter =
            \ "'docformatter --wrap-summaries 100 --wrap-descriptions 100 --blank -'"
let g:formatdef_black = "'black -q -l 100 -'"
let g:formatdef_pyupgrade = "'pyupgrade --py36-plus -'"
let g:formatdef_python_format = join([
            \   g:formatdef_isort[:-2],
            \   g:formatdef_pyupgrade[1:-2],
            \   g:formatdef_black[1:],
            \ ], ' | ')
            " \   g:formatdef_docformatter[1:-2],
let g:formatters_python = ['python_format']

let g:formatdef_rstfmt = "'rstfmt -w 100'"
let g:formatters_rst = ['rstfmt']

let g:formatdef_prettier = "'prettier --print-width=100 --tab-width=4 --parser='.&filetype"
let g:formatdef_prettier_json = "'prettier --print-width=100 --tab-width=4 --parser=json'"
let g:formatdef_prettier_yaml = "'prettier --print-width=100 --tab-width=2 --parser='.&filetype"
let g:formatdef_prettier_javascript = "'prettier --print-width=100 --tab-width=4 --parser=babel'"
let g:formatdef_json_tool = "'python3 -m json.tool'"
let g:formatdef_jq = "'jq -M --indent 4'"
" let g:formatters_json = ['json_tool']
" let g:formatters_json = ['jq']
let g:formatters_markdown = ['prettier']
let g:formatters_html = ['prettier']
let g:formatters_css = ['prettier']
let g:formatters_javascript = ['prettier_javascript']
let g:formatters_yaml = ['prettier_yaml']
let g:formatters_json = ['prettier_json']
let g:formatters_jsonc = ['prettier_json']

let g:formatdef_prettydiff = "'$MY_LINTER_PATH/prettydiff.sh beautify ".
            \                "warp:100 indent_size:4 preserve:2 space_close:true'"
let g:formatters_xml = ['prettydiff']

let g:formatters_sh = ['shfmt']

let g:formatdef_cmake_format = "'cmake-format --line-width=100 --tab-size=4 ".
            \                  "--enable-markup=false -'"
let g:formatters_cmake = ['cmake_format']

let g:formatdef_phpcbf = "'phpcbf --standard=$MY_LINTER_PATH/phpcs.xml -; true'"
let g:formatters_php = ['phpcbf']

let g:autoformat_verbosemode = 0

function s:VimFormat(is_visual) abort
    let l:winview = winsaveview()
    try
        let l:cmd = a:is_visual ? 'gv=' : 'gg=G'
        silent execute 'noautocmd keepjump normal! '. l:cmd
        RemoveTrailingSpaces
    finally
        noautocmd call winrestview(l:winview)
    endtry
endfunction

function s:AutoCmdAutoformat() abort
    nnoremap <silent><buffer> <leader>a :<C-u>call <SID>VimFormat(0)<CR>
    xnoremap <silent><buffer> <leader>a :<C-u>call <SID>VimFormat(1)<CR>
endfunction

augroup myAutoformat
    autocmd!
    autocmd FileType vim call s:AutoCmdAutoformat()
augroup END

nnoremap <silent> <leader>a :Autoformat<CR>
xnoremap <silent> <leader>a :Autoformat<CR>

nnoremap <leader>jq :%!jq -M -r --indent 4<CR>
xnoremap <leader>jq :!jq -M -r --indent 4<CR>
nnoremap <leader>jc :%!jq -M -c<CR>
xnoremap <leader>jc :!jq -M -c<CR>
nnoremap <leader>j\ :%!jq -M @json<CR>
xnoremap <leader>j\ :!jq -M @json<CR>
