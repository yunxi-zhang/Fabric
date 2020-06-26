#!/bin/bash

# import common.sh
source ./common.sh

stepInfo "Download Bins And Config Folders For Hyperledger Fabric"
export VERSION=1.4.0
export ARCH=$(echo "$(uname -s|tr '[:upper:]' '[:lower:]'|sed 's/mingw64_nt.*/windows/')-$(uname -m | sed 's/x86_64/amd64/g')" | awk '{print tolower($0)}')

echo "===> Downloading platform binaries"
export URL="https://github.com/hyperledger/fabric/releases/download/v$VERSION/hyperledger-fabric-darwin-amd64-$VERSION.tar.gz"
echo $URL
curl -L $URL  > hyperledger-fabric-darwin-amd64-$VERSION.tar.gz
tar -xf hyperledger-fabric-darwin-amd64-$VERSION.tar.gz
rm -rf hyperledger-fabric-darwin-amd64-$VERSION.tar.gz