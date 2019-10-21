#!/bin/bash

# https://github.com/bazelbuild/buildtools/tree/master/buildifier

pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null
set -e
set -v

######################
# Install Buildifier #
######################

VERSION="0.29.0"
TARFILE=$VERSION.tar.gz
DIR=buildtools-$VERSION

if [ ! -d $DIR ]; then
    wget https://github.com/bazelbuild/buildtools/archive/$TARFILE

    tar -xvf $TARFILE
    rm $TARFILE
fi

pushd $DIR >/dev/null
bazel build //buildifier

mkdir -p ~/.local/bin
sudo cp bazel-bin/buildifier/linux_amd64_stripped/buildifier ~/.local/bin

popd >/dev/null
rm -rf $DIR

popd >/dev/null
