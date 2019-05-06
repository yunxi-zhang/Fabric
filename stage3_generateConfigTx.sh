#!/bin/bash

# import common.sh
source ./common.sh

stepInfo "Generate Configuration Transaction Artifacts"
mkdir ./channel-artifacts
# generate the genesis block
./bin/configtxgen -configPath ./ -profile OrdererGenesis -outputBlock ./channel-artifacts/genesis.block 
stepInfo "Generating files for $CHANNEL_NAME1"
# generate channel transaction artifact in channel1
./bin/configtxgen -configPath ./ -profile $CHANNEL_PROFILE1 -outputCreateChannelTx ./channel-artifacts/$CHANNEL_NAME1.tx -channelID $CHANNEL_NAME1
# generate anchor peer for seller in channel1
./bin/configtxgen -configPath ./ -profile $CHANNEL_PROFILE1 -outputAnchorPeersUpdate ./channel-artifacts/sellerMSPanchors_$CHANNEL_NAME1.tx -channelID $CHANNEL_NAME1 -asOrg SellerMSP
# generate anchor peer for bank in channel1
./bin/configtxgen -configPath ./ -profile $CHANNEL_PROFILE1 -outputAnchorPeersUpdate ./channel-artifacts/bankMSPanchors_$CHANNEL_NAME1.tx -channelID $CHANNEL_NAME1 -asOrg BankMSP

stepInfo "Generating files for $CHANNEL_NAME2"
# generate channel transaction artifact in channel2
./bin/configtxgen -configPath ./ -profile $CHANNEL_PROFILE2 -outputCreateChannelTx ./channel-artifacts/$CHANNEL_NAME2.tx -channelID $CHANNEL_NAME2
# generate anchor peer for buyer in channel2
./bin/configtxgen -configPath ./ -profile $CHANNEL_PROFILE2 -outputAnchorPeersUpdate ./channel-artifacts/buyerMSPanchors_$CHANNEL_NAME2.tx -channelID $CHANNEL_NAME2 -asOrg BuyerMSP
# generate anchor peer for bank in channel2
./bin/configtxgen -configPath ./ -profile $CHANNEL_PROFILE2 -outputAnchorPeersUpdate ./channel-artifacts/bankMSPanchors_$CHANNEL_NAME2.tx -channelID $CHANNEL_NAME2 -asOrg BankMSP