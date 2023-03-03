# Language Support for Ubuntu 20.04

#### Git

```bash
pip3 install gitlint
```

#### Bash

```bash
npm install --global bash-language-server
snap install shfmt
apt install shellcheck
```

#### Python

```bash
pip3 install \
    black \
    isort \
    pyupgrade \
    docformatter \
    ipython \
    pylint \
    flake8 \
    flake8-docstrings \
    darglint \
    mypy \
    rstcheck \
    rstfmt
```

#### C/C++

```bash
pip3 install cpplint
apt install \
    clang-format \
    cppcheck \
    ccls
```

#### Bazel

```bash
./setup/install_buildifier.sh
```

#### Json

```bash
pip3 install demjson3
npm install --global prettier
apt install jq
```

#### Markdown

```bash
npm install --global prettier
npm install --global markdownlint-cli
```

#### Cmake

```bash
pip3 install \
    cmake_format \
    cmakelint
```

#### Dockerfile

```bash
npm install --global dockerfile-language-server-nodejs
./setup/install_hadolint.sh
```

#### Php

```bash
apt install php-codesniffer
```

#### Xml

```bash
npm install --global prettydiff
```

#### Yaml

```bash
pip3 install yamllint
```

#### VimScript

```bash
pip3 install vim-vint
```
