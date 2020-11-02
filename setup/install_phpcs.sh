#!/bin/bash

# https://github.com/squizlabs/PHP_CodeSniffer

[ -r /etc/lsb-release ] && source /etc/lsb-release
if [ "$DISTRIB_CODENAME" != 'xenial' ]; then
    echo 'Only support ubuntu 16.04'
    exit 1
fi

set -euo pipefail
set -x

############################
# Install php-code-sniffer #
############################

readonly VERSION="3.5.4"
readonly TARGET_PHPCS="/usr/local/bin/phpcs"
readonly TARGET_PHPCBF="/usr/local/bin/phpcbf"

if ! dpkg -s wget &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

sudo wget https://github.com/squizlabs/PHP_CodeSniffer/releases/download/$VERSION/phpcs.phar \
    -O $TARGET_PHPCS
sudo wget https://github.com/squizlabs/PHP_CodeSniffer/releases/download/$VERSION/phpcbf.phar \
    -O $TARGET_PHPCBF

sudo chmod +x $TARGET_PHPCS $TARGET_PHPCBF
