#!/bin/bash

# import common.sh
source ./common.sh

# type in a new version for chaincode
stepInfo "Please type in a new version for installing the chaincode"
read CHAINCODE_VERSION
stepInfo "The typedin chaincode version is: $CHAINCODE_VERSION"

# type in a chaincode name
stepInfo "Please type in a chaincode name"
read CHAINCODE_NAME
stepInfo "The received chaincode name is: $CHAINCODE_NAME"

# type in a language for build
stepInfo "Please type in a build language, can only be (1) golang (2) node and (3) java"
read BUILD_LANGUAGE
stepInfo "The received build language is: $BUILD_LANGUAGE"

stepInfo "Install Chaincode On Peer0 Of Seller"
docker exec -it cli peer chaincode install -n $CHAINCODE_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p /opt/gopath/src/github.com/chaincode/buy_sell/$BUILD_LANGUAGE/
stepInfo "Install Chaincode On Peer0 Of Buyer"
docker exec -it cli peer chaincode install -n $CHAINCODE_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p /opt/gopath/src/github.com/chaincode/buy_sell/$BUILD_LANGUAGE/

stepInfo "Instantiate Chaincode"
docker exec -it cli peer chaincode instantiate -o orderer.yunxi.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem -C $CHANNEL_NAME -n $CHAINCODE_NAME -l $BUILD_LANGUAGE -v $CHAINCODE_VERSION -c '{"Args":["init"]}' -P "AND ('SellerMSP.peer','BuyerMSP.peer')"
