#!/bin/bash

set -e
set -v

VERSION="0.28.0"
TARFILE=$VERSION.tar.gz
DIR=buildtools-$VERSION

wget https://github.com/bazelbuild/buildtools/archive/$TARFILE

tar -xvf $TARFILE
pushd $DIR > /dev/null
bazel build //buildifier

mkdir -p ~/.local/bin
sudo cp bazel-bin/buildifier/linux_amd64_stripped/buildifier ~/.local/bin

popd > /dev/null
rm $TARFILE
rm -rf $DIR
