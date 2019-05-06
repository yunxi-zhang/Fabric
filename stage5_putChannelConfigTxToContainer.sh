#!/bin/bash

# import common.sh
source ./common.sh

stepInfo "Create A 1st Channel $CHANNEL_NAME1"
docker exec -it cli peer channel create -o orderer.yunxi.com:7050 -c $CHANNEL_NAME1 -f ./channel-artifacts/$CHANNEL_NAME1.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem
stepInfo "Peer0 of Bank Joins This Channel"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.yunxi.com/users/Admin@bank.yunxi.com/msp \
-e CORE_PEER_ADDRESS=peer0.bank.yunxi.com:7051 -e CORE_PEER_LOCALMSPID="BankMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.yunxi.com/peers/peer0.bank.yunxi.com/tls/ca.crt \
cli peer channel join -b $CHANNEL_NAME1.block
stepInfo "Peer0 of Seller Joins This Channel"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/users/Admin@seller.yunxi.com/msp \
-e CORE_PEER_ADDRESS=peer0.seller.yunxi.com:7051 -e CORE_PEER_LOCALMSPID="SellerMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/peers/peer0.seller.yunxi.com/tls/ca.crt \
cli peer channel join -b $CHANNEL_NAME1.block
stepInfo "Update Anchor Peer For Bank"
docker exec -it \
cli peer channel update -o orderer.yunxi.com:7050 -c $CHANNEL_NAME1 -f ./channel-artifacts/BankMSPanchors_$CHANNEL_NAME1.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem
stepInfo "Update Anchor Peer For Seller"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/users/Admin@seller.yunxi.com/msp -e CORE_PEER_ADDRESS=peer0.seller.yunxi.com:7051 -e CORE_PEER_LOCALMSPID="SellerMSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/peers/peer0.seller.yunxi.com/tls/ca.crt \
cli peer channel update -o orderer.yunxi.com:7050 -c $CHANNEL_NAME1 -f ./channel-artifacts/sellerMSPanchors_$CHANNEL_NAME1.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem

stepInfo "Create A 2nd Channel $CHANNEL_NAME2"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.yunxi.com/users/Admin@bank.yunxi.com/msp \
-e CORE_PEER_LOCALMSPID=BankMSP \
cli peer channel create -o orderer.yunxi.com:7050 -c $CHANNEL_NAME2 -f ./channel-artifacts/$CHANNEL_NAME2.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem
stepInfo "Peer0 of Bank Joins This Channel"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.yunxi.com/users/Admin@bank.yunxi.com/msp \
-e CORE_PEER_ADDRESS=peer0.bank.yunxi.com:7051 -e CORE_PEER_LOCALMSPID="BankMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.yunxi.com/peers/peer0.bank.yunxi.com/tls/ca.crt \
cli peer channel join -b $CHANNEL_NAME2.block
stepInfo "Peer0 of Buyer Joins This Channel"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com/msp \
-e CORE_PEER_ADDRESS=peer0.buyer.yunxi.com:7051 -e CORE_PEER_LOCALMSPID="BuyerMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/ca.crt \
cli peer channel join -b $CHANNEL_NAME2.block
stepInfo "Update Anchor Peer For Bank"
docker exec -it \
cli peer channel update -o orderer.yunxi.com:7050 -c $CHANNEL_NAME2 -f ./channel-artifacts/bankMSPanchors_$CHANNEL_NAME2.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem
stepInfo "Update Anchor Peer For Buyer"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com/msp -e CORE_PEER_ADDRESS=peer0.buyer.yunxi.com:7051 -e CORE_PEER_LOCALMSPID="BuyerMSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/ca.crt \
cli peer channel update -o orderer.yunxi.com:7050 -c $CHANNEL_NAME2 -f ./channel-artifacts/buyerMSPanchors_$CHANNEL_NAME2.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem