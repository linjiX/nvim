#!/bin/bash

# https://github.com/BurntSushi/ripgrep/releases

set -e
set -v

VERSION="11.0.1"
DEBFILE=ripgrep_${VERSION}_amd64.deb

wget https://github.com/BurntSushi/ripgrep/releases/download/$VERSION/$DEBFILE

sudo dpkg -i $DEBFILE

rm $DEBFILE
