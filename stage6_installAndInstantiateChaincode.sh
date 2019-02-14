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

stepInfo "Install Chaincode On Peer0 Of Seller"
docker exec -it cli peer chaincode install -n $CHAINCODE_NAME -v $CHAINCODE_VERSION -l node -p /opt/gopath/src/github.com/chaincode/buy_sell/node/
stepInfo "Install Chaincode On Peer0 Of Buyer"
docker exec -it cli peer chaincode install -n $CHAINCODE_NAME -v $CHAINCODE_VERSION -l node -p /opt/gopath/src/github.com/chaincode/buy_sell/node/

stepInfo "Instantiate Chaincode"
docker exec -it cli peer chaincode instantiate -o orderer.yunxi.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem -C $CHANNEL_NAME -n $CHAINCODE_NAME -l node -v $CHAINCODE_VERSION -c '{"Args":["init"]}' -P "AND ('SellerMSP.peer','BuyerMSP.peer')"
