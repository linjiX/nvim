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

call ale#linter#Define('cpp', {
            \   'name': 'CppCheck',
            \   'output_stream': 'both',
            \   'executable': 'cppcheck',
            \   'command': '%e -q --language=c++ --std=c++17 --enable=all --platform=unix64 '.
            \              '--suppress=unusedFunction '.
            \              '--suppress=unusedStructMember '.
            \              '--template="{file}:{line}:{column} {severity}:{id}:{message}" '.
            \              '--template-location="{file}:{line}:{column} {info}" %t',
            \   'callback': 'lint#cpp#HandleCppCheckFormat',
            \})

call ale#linter#Define('bzl', {
            \   'name': 'Buildifier',
            \   'output_stream': 'both',
            \   'executable': 'buildifier',
            \   'command': '%e --lint=warn --format=json --mode=check %t',
            \   'callback': 'lint#bzl#HandleBuildifierFormat',
            \})

call ale#linter#Define('json', {
            \   'name': 'Jsonlint',
            \   'output_stream': 'both',
            \   'executable': 'jsonlint',
            \   'command': '%e %t',
            \   'callback': 'lint#json#HandleJsonlintFormat',
            \})

call ale#linter#Define('markdown', {
            \   'name': 'markdownlint-cli',
            \   'executable': 'markdownlint',
            \   'output_stream': 'both',
            \   'command': '%e --config='. $HOME .'/.vim/markdownlint.json %t',
            \   'callback': 'lint#markdown#HandleMarkdownlintFormat'
            \})
