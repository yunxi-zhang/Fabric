#!/bin/bash
echo -e "\x1b[33mGenerate Configuration Transaction Artifacts \x1b[0m "
mkdir ./channel-artifacts
# generate the genesis block
./bin/configtxgen -configPath ./ -profile TwoOrgsOrdererGenesis -channelID seller-buyer-channel -outputBlock ./channel-artifacts/genesis.block 
# generate channel transaction artifact
./bin/configtxgen -configPath ./ -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID channel1
# generate anchor peer for seller
./bin/configtxgen -configPath ./ -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/sellerMSPanchors.tx -channelID channel1 -asOrg SellerMSP
# generate anchor peer for buyer
./bin/configtxgen -configPath ./ -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/buyerMSPanchors.tx -channelID channel1 -asOrg BuyerMSP
