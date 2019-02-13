#!/bin/bash
mkdir ./channel-artifacts
# generate the genesis block
./bin/configtxgen -configPath ./ -profile TwoOrgsOrdererGenesis -channelID seller-buyer-channel -outputBlock ./channel-artifacts/genesis.block 
# generate channel transaction artifact
./bin/configtxgen -configPath ./ -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID channel1