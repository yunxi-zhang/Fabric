#!/bin/bash

# import common.sh
source ./common.sh

stepInfo "Generate Configuration Transaction Artifacts"
mkdir ./channel-artifacts
# generate the genesis block
./bin/configtxgen -configPath ./ -profile TwoOrgsOrdererGenesis -channelID seller-buyer-channel -outputBlock ./channel-artifacts/genesis.block 
# generate channel transaction artifact
./bin/configtxgen -configPath ./ -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNELNAME
# generate anchor peer for seller
./bin/configtxgen -configPath ./ -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/sellerMSPanchors.tx -channelID $CHANNELNAME -asOrg SellerMSP
# generate anchor peer for buyer
./bin/configtxgen -configPath ./ -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/buyerMSPanchors.tx -channelID $CHANNELNAME -asOrg BuyerMSP
