#!/bin/bash

# https://www.bazel.build/

set -e
set -v

#################
# Install Bazel #
#################

sudo apt-get update
sudo apt-get install -y openjdk-8-jdk curl

echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" |
    sudo tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y bazel
