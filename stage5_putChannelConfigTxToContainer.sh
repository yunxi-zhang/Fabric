#!/bin/bash

# import common.sh
source ./common.sh

stepInfo "Create A 1st Channel $CHANNEL_NAME1"
docker exec -it cli peer channel create -o orderer.admincom:7050 -c $CHANNEL_NAME1 -f ./channel-artifacts/$CHANNEL_NAME1.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/admincom/orderers/orderer.admincom/msp/tlscacerts/tlsca.admincom-cert.pem
stepInfo "Peer0 of Bank Joins This Channel"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.admincom/users/Admin@bank.admincom/msp \
-e CORE_PEER_ADDRESS=peer0.bank.admincom:7051 -e CORE_PEER_LOCALMSPID="BankMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.admincom/peers/peer0.bank.admincom/tls/ca.crt \
cli peer channel join -b $CHANNEL_NAME1.block
stepInfo "Peer0 of Seller Joins This Channel"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.admincom/users/Admin@seller.admincom/msp \
-e CORE_PEER_ADDRESS=peer0.seller.admincom:7051 -e CORE_PEER_LOCALMSPID="SellerMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.admincom/peers/peer0.seller.admincom/tls/ca.crt \
cli peer channel join -b $CHANNEL_NAME1.block
stepInfo "Update Anchor Peer For Bank"
docker exec -it \
cli peer channel update -o orderer.admincom:7050 -c $CHANNEL_NAME1 -f ./channel-artifacts/BankMSPanchors_$CHANNEL_NAME1.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/admincom/orderers/orderer.admincom/msp/tlscacerts/tlsca.admincom-cert.pem
stepInfo "Update Anchor Peer For Seller"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.admincom/users/Admin@seller.admincom/msp -e CORE_PEER_ADDRESS=peer0.seller.admincom:7051 -e CORE_PEER_LOCALMSPID="SellerMSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.admincom/peers/peer0.seller.admincom/tls/ca.crt \
cli peer channel update -o orderer.admincom:7050 -c $CHANNEL_NAME1 -f ./channel-artifacts/sellerMSPanchors_$CHANNEL_NAME1.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/admincom/orderers/orderer.admincom/msp/tlscacerts/tlsca.admincom-cert.pem

stepInfo "Create A 2nd Channel $CHANNEL_NAME2"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.admincom/users/Admin@bank.admincom/msp \
-e CORE_PEER_LOCALMSPID=BankMSP \
cli peer channel create -o orderer.admincom:7050 -c $CHANNEL_NAME2 -f ./channel-artifacts/$CHANNEL_NAME2.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/admincom/orderers/orderer.admincom/msp/tlscacerts/tlsca.admincom-cert.pem
stepInfo "Peer0 of Bank Joins This Channel"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.admincom/users/Admin@bank.admincom/msp \
-e CORE_PEER_ADDRESS=peer0.bank.admincom:7051 -e CORE_PEER_LOCALMSPID="BankMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.admincom/peers/peer0.bank.admincom/tls/ca.crt \
cli peer channel join -b $CHANNEL_NAME2.block
stepInfo "Peer0 of Buyer Joins This Channel"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.admincom/users/Admin@buyer.admincom/msp \
-e CORE_PEER_ADDRESS=peer0.buyer.admincom:7051 -e CORE_PEER_LOCALMSPID="BuyerMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.admincom/peers/peer0.buyer.admincom/tls/ca.crt \
cli peer channel join -b $CHANNEL_NAME2.block
stepInfo "Update Anchor Peer For Bank"
docker exec -it \
cli peer channel update -o orderer.admincom:7050 -c $CHANNEL_NAME2 -f ./channel-artifacts/bankMSPanchors_$CHANNEL_NAME2.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/admincom/orderers/orderer.admincom/msp/tlscacerts/tlsca.admincom-cert.pem
stepInfo "Update Anchor Peer For Buyer"
docker exec -it \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.admincom/users/Admin@buyer.admincom/msp -e CORE_PEER_ADDRESS=peer0.buyer.admincom:7051 -e CORE_PEER_LOCALMSPID="BuyerMSP" \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.admincom/peers/peer0.buyer.admincom/tls/ca.crt \
cli peer channel update -o orderer.admincom:7050 -c $CHANNEL_NAME2 -f ./channel-artifacts/buyerMSPanchors_$CHANNEL_NAME2.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/admincom/orderers/orderer.admincom/msp/tlscacerts/tlsca.admincom-cert.pem