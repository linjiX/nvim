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

call ale#Set('cpp_CppCheck_executable', 'cppcheck')
call ale#Set('cpp_CppCheck_options', '')
call ale#linter#Define('cpp', {
            \   'name': 'CppCheck',
            \   'output_stream': 'both',
            \   'executable': {b -> ale#Var(b, 'cpp_CppCheck_executable')},
            \   'command': function('lint#cpp#GetCppCheckCommand'),
            \   'callback': 'lint#cpp#HandleCppCheckFormat',
            \})

call ale#Set('bzl_buildifier_executable', 'buildifier')
call ale#Set('bzl_buildifier_options', '')
call ale#linter#Define('bzl', {
            \   'name': 'Buildifier',
            \   'output_stream': 'both',
            \   'executable': {b -> ale#Var(b, 'bzl_buildifier_executable')},
            \   'command': function('lint#bzl#GetBuildifierCommand'),
            \   'callback': 'lint#bzl#HandleBuildifierFormat',
            \})

call ale#Set('json_Jsonlint_executable', 'jsonlint')
call ale#Set('json_Jsonlint_options', '')
call ale#linter#Define('json', {
            \   'name': 'Jsonlint',
            \   'output_stream': 'both',
            \   'executable': {b -> ale#Var(b, 'json_Jsonlint_executable')},
            \   'command': function('lint#json#GetJsonlintCommand'),
            \   'callback': 'lint#json#HandleJsonlintFormat',
            \})

call ale#Set('markdown_markdownlint_cli_executable', 'markdownlint')
call ale#Set('markdown_markdownlint_cli_options', '')
call ale#linter#Define('markdown', {
            \   'name': 'markdownlint-cli',
            \   'output_stream': 'both',
            \   'executable': {b -> ale#Var(b, 'markdown_markdownlint_cli_executable')},
            \   'command': function('lint#markdown#GetMarkdownlintCommand'),
            \   'callback': 'lint#markdown#HandleMarkdownlintFormat'
            \})
