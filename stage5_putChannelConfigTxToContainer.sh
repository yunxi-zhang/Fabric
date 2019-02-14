#!/bin/bash

# import common.sh
source ./common.sh

stepInfo "Create A Channel"
docker exec -it cli peer channel create -o orderer.yunxi.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem
stepInfo "Peer0 of Seller Joins This Channel"
docker exec -it cli peer channel join -b $CHANNEL_NAME.block
stepInfo "Peer0 of Buyer Joins This Channel"
docker exec -it -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com/msp -e CORE_PEER_ADDRESS=peer0.buyer.yunxi.com:7051 -e CORE_PEER_LOCALMSPID="BuyerMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/ca.crt cli peer channel join -b $CHANNEL_NAME.block
stepInfo "Update Anchor Peer For Seller"
docker exec -it cli peer channel update -o orderer.yunxi.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/sellerMSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem
stepInfo "Update Anchor Peer For Buyer"
docker exec -it -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com/msp -e CORE_PEER_ADDRESS=peer0.buyer.yunxi.com:7051 -e CORE_PEER_LOCALMSPID="BuyerMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/ca.crt cli peer channel update -o orderer.yunxi.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/BuyerMSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem