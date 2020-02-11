#!/bin/bash

# https://github.com/squizlabs/PHP_CodeSniffer

set -e
set -v

############################
# Install php-code-sniffer #
############################

VERSION="3.5.4"

if ! dpkg -s wget 1>/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y wget
fi

TMPDIR="$(mktemp -d /tmp/install_phpcs.XXXX)"
pushd "$TMPDIR" >/dev/null

wget -c https://github.com/squizlabs/PHP_CodeSniffer/releases/download/$VERSION/phpcs.phar \
    -O phpcs
wget -c https://github.com/squizlabs/PHP_CodeSniffer/releases/download/$VERSION/phpcbf.phar \
    -O phpcbf

chmod +x phpcs phpcbf
sudo mv phpcs phpcbf /usr/local/bin

popd >/dev/null
