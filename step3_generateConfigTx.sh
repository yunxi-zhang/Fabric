#!/bin/bash
mkdir ./channel-artifacts
./bin/configtxgen -configPath ./ -profile TwoOrgsOrdererGenesis -channelID seller-buyer-channel -outputBlock ./channel-artifacts/genesis.block 