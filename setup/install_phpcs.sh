#!/bin/bash

# https://github.com/squizlabs/PHP_CodeSniffer

set -e
set -v

############################
# Install php-code-sniffer #
############################

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

TMPDIR="$(mktemp -d /tmp/install_phpcs.XXXX)"
pushd "$TMPDIR" >/dev/null

wget -c https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
wget -c https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar

sudo mv phpcs.phar /usr/local/bin/phpcs
sudo mv phpcbf.phar /usr/local/bin/phpcbf
sudo chmod +x /usr/local/bin/phpcs
sudo chmod +x /usr/local/bin/phpcbf

popd >/dev/null
