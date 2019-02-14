#!/bin/bash

# import common.sh
source ./common.sh

stepInfo "Install Chaincode On Peer0 Of Seller"
docker exec -it -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/users/Admin@seller.yunxi.com/msp -e CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/tls/ca.crt peer0.seller.yunxi.com peer chaincode install -n chaincode_buy_sell -v 0.1 -l node -p /opt/gopath/src/github.com/chaincode/buy_sell/node/
stepInfo "Install Chaincode On Peer0 Of Buyer"
docker exec -it -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com/msp -e CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/tls/ca.crt peer0.buyer.yunxi.com peer chaincode install -n chaincode_buy_sell -v 0.1 -l node -p /opt/gopath/src/github.com/chaincode/buy_sell/node/
