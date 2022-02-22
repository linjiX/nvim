# Language Support for Ubuntu 16.04

#### Git

```bash
pip3 install gitlint
```

#### Bash

```bash
npm install --global bash-language-server
snap install shfmt
snap install shellcheck
```

#### Python

```bash
pip3 install \
    black \
    isort \
    docformatter \
    pyupgrade \
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
./setup/install_clang_format.sh
./setup/install_cppcheck.sh
./setup/install_ccls.sh
```

#### Bazel

```bash
./setup/install_buildifier.sh
```

#### Json

```bash
pip3 install demjson
npm install --global prettier
./setup/install_jq.sh
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
./setup/install_phpcs.sh
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
