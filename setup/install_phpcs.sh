#!/bin/bash

# https://github.com/squizlabs/PHP_CodeSniffer

set -e
set -v

############################
# Install php-code-sniffer #
############################

VERSION="3.5.4"
TARGET_PHPCS="/usr/local/bin/phpcs"
TARGET_PHPCBF="/usr/local/bin/phpcbf"

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

sudo wget -c https://github.com/squizlabs/PHP_CodeSniffer/releases/download/$VERSION/phpcs.phar \
    -O $TARGET_PHPCS
sudo wget -c https://github.com/squizlabs/PHP_CodeSniffer/releases/download/$VERSION/phpcbf.phar \
    -O $TARGET_PHPCBF

sudo chmod +x $TARGET_PHPCS $TARGET_PHPCBF
