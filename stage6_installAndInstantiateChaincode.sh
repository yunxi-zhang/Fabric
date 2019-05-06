#!/bin/bash

# import common.sh
source ./common.sh

# type in a new version for chaincode
CHAINCODE_VERSION=0.1
stepInfo "The chaincode version is: $CHAINCODE_VERSION"

# type in a chaincode name
CHAINCODE_NAME=cc
CONTRACT_NAME=exchange
stepInfo "The chaincode name is: $CHAINCODE_NAME"
stepInfo "The contract name is: $CONTRACT_NAME"

# type in a language for build
# stepInfo "Please select a number for a build language:"
# export PS3="Please make a selection =>"
# select BUILD_LANGUAGE in golang node java
# do
#     case $BUILD_LANGUAGE in
#         golang) stepInfo "You've picked $BUILD_LANGUAGE"; break;;
#         node) stepInfo "You've picked $BUILD_LANGUAGE"; break;;
#         java) stepInfo "You've picked $BUILD_LANGUAGE"; break;;
#         *) stepInfo "Invalid option. Try again.";continue;;
#     esac
# done

# node is the only currently used language in this repo
BUILD_LANGUAGE=node

# Golang uses a relative path, and the ABSOLUTE_PATH_PREFIX will be auto added to the CHAINCODE_PATH
# ABSOLUTE_PATH_PREFIX is only used when node or java has been selected as the build language
ABSOLUTE_PATH_PREFIX="/opt/gopath/src"
CHAINCODE_PATH="github.com/chaincode/buy_sell"
CONTRACT_PATH="github.com/chaincode/exchange"

stepInfo "Install Chaincode On Peer0 Of Bank"
    if [ $BUILD_LANGUAGE = "golang" ]
    then 
        stepInfo "Use The Relative Path"
        stepInfo "Chaincode file is in the path: $CHAINCODE_PATH/$BUILD_LANGUAGE/"
        docker exec -it cli peer chaincode install -n $CHAINCODE_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p $CHAINCODE_PATH/$BUILD_LANGUAGE/
    else
        stepInfo "Use The Absolute Path"
        stepInfo "Chaincode file is in the path: $ABSOLUTE_PATH_PREFIX/$CHAINCODE_PATH/$BUILD_LANGUAGE/"
        docker exec -it cli peer chaincode install -n $CHAINCODE_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p $ABSOLUTE_PATH_PREFIX/$CHAINCODE_PATH/$BUILD_LANGUAGE/
    fi

stepInfo "Install Chaincode On Peer0 Of Seller"
    if [ $BUILD_LANGUAGE = "golang" ]
    then 
        stepInfo "Use The Relative Path"
        stepInfo "Chaincode file is in the path: $CHAINCODE_PATH/$BUILD_LANGUAGE/"
        docker exec -it cli \
        -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/users/Admin@seller.yunxi.com/msp \
        -e CORE_PEER_ADDRESS=peer0.seller.yunxi.com:7051 \
        -e CORE_PEER_LOCALMSPID=SellerMSP \
        -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/peers/peer0.seller.yunxi.com/tls/ca.crt \
        -e CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/peers/peer0.seller.yunxi.com/tls/server.key \
        -e CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/peers/peer0.seller.yunxi.com/tls/server.crt \
        cli peer chaincode install -n $CHAINCODE_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p $CHAINCODE_PATH/$BUILD_LANGUAGE/
    else
        stepInfo "Use The Absolute Path"
        stepInfo "Chaincode file is in the path: $ABSOLUTE_PATH_PREFIX/$CHAINCODE_PATH/$BUILD_LANGUAGE/"
        docker exec -it \
        -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/users/Admin@seller.yunxi.com/msp \
        -e CORE_PEER_ADDRESS=peer0.seller.yunxi.com:7051 \
        -e CORE_PEER_LOCALMSPID=SellerMSP \
        -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/peers/peer0.seller.yunxi.com/tls/ca.crt \
        -e CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/peers/peer0.seller.yunxi.com/tls/server.key \
        -e CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/peers/peer0.seller.yunxi.com/tls/server.crt \
        cli peer chaincode install -n $CHAINCODE_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p $ABSOLUTE_PATH_PREFIX/$CHAINCODE_PATH/$BUILD_LANGUAGE/
    fi

stepInfo "Install Chaincode On Peer0 Of Buyer"
if [ $BUILD_LANGUAGE = "golang" ]
then 
    stepInfo "Use The Relative Path"
    stepInfo "Chaincode file is in the path: $CHAINCODE_PATH/$BUILD_LANGUAGE/"
    docker exec -it \
    -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com/msp \
    -e CORE_PEER_ADDRESS=peer0.buyer.yunxi.com:7051 \
    -e CORE_PEER_LOCALMSPID=BuyerMSP \
    -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/ca.crt \
    -e CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/server.key \
    -e CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/server.crt \
    cli peer chaincode install -n $CHAINCODE_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p $CHAINCODE_PATH/$BUILD_LANGUAGE/
else
    stepInfo "Use The Absolute Path"
    stepInfo "Chaincode file is in the path: $ABSOLUTE_PATH_PREFIX/$CHAINCODE_PATH/$BUILD_LANGUAGE/"
    docker exec -it \
    -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com/msp \
    -e CORE_PEER_ADDRESS=peer0.buyer.yunxi.com:7051 \
    -e CORE_PEER_LOCALMSPID=BuyerMSP \
    -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/ca.crt \
    -e CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/server.key \
    -e CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/server.crt \
    cli peer chaincode install -n $CHAINCODE_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p $ABSOLUTE_PATH_PREFIX/$CHAINCODE_PATH/$BUILD_LANGUAGE/
fi

# stepInfo "Install Contract On Peer0 Of Seller"
#     if [ $BUILD_LANGUAGE = "golang" ]
#     then 
#         stepInfo "Use The Relative Path"
#         stepInfo "Chaincode file is in the path: $CHAINCODE_PATH/$BUILD_LANGUAGE/"
#         docker exec -it cli peer chaincode install -n $CONTRACT_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p $CONTRACT_PATH/$BUILD_LANGUAGE/
#     else
#         stepInfo "Use The Absolute Path"
#         stepInfo "Chaincode file is in the path: $ABSOLUTE_PATH_PREFIX/$CHAINCODE_PATH/$BUILD_LANGUAGE/"
#         docker exec -it cli peer chaincode install -n $CONTRACT_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p $ABSOLUTE_PATH_PREFIX/$CONTRACT_PATH/$BUILD_LANGUAGE/
#     fi

# stepInfo "Install Contract On Peer0 Of Buyer"
# if [ $BUILD_LANGUAGE = "golang" ]
# then 
#     stepInfo "Use The Relative Path"
#     stepInfo "Chaincode file is in the path: $CONTRACT_PATH/$BUILD_LANGUAGE/"
#     docker exec -it \
#     -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com/msp \
#     -e CORE_PEER_ADDRESS=peer0.buyer.yunxi.com:7051 \
#     -e CORE_PEER_LOCALMSPID=BuyerMSP \
#     -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/ca.crt \
#     -e CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/server.key \
#     -e CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/server.crt \
#     cli peer chaincode install -n $CONTRACT_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p $CONTRACT_PATH/$BUILD_LANGUAGE/
# else
#     stepInfo "Use The Absolute Path"
#     stepInfo "Chaincode file is in the path: $ABSOLUTE_PATH_PREFIX/$CONTRACT_PATH/$BUILD_LANGUAGE/"
#     docker exec -it \
#     -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com/msp \
#     -e CORE_PEER_ADDRESS=peer0.buyer.yunxi.com:7051 \
#     -e CORE_PEER_LOCALMSPID=BuyerMSP \
#     -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/ca.crt \
#     -e CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/server.key \
#     -e CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/buyer.yunxi.com/peers/peer0.buyer.yunxi.com/tls/server.crt \
#     cli peer chaincode install -n $CONTRACT_NAME -v $CHAINCODE_VERSION -l $BUILD_LANGUAGE -p $ABSOLUTE_PATH_PREFIX/$CONTRACT_PATH/$BUILD_LANGUAGE/
# fi

stepInfo "Instantiate Chaincode On Peer0 Of Bank on channel $CHANNEL_NAME1"
INIT_CHAINCODE_PARAMETERS='{"Args":["init", "sellerBalance", "100"]}'
docker exec -it cli peer chaincode instantiate -o orderer.yunxi.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem -C $CHANNEL_NAME1 -n $CHAINCODE_NAME -l $BUILD_LANGUAGE -v $CHAINCODE_VERSION -c "$INIT_CHAINCODE_PARAMETERS" -P 'OR ("SellerMSP.peer","BankMSP.peer")'

stepInfo "Instantiate Chaincode On Peer0 Of Bank on channel $CHANNEL_NAME2"
INIT_CHAINCODE_PARAMETERS='{"Args":["init", "buyerBalance", "200"]}'
docker exec -it cli peer chaincode instantiate -o orderer.yunxi.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem -C $CHANNEL_NAME2 -n $CHAINCODE_NAME -l $BUILD_LANGUAGE -v $CHAINCODE_VERSION -c "$INIT_CHAINCODE_PARAMETERS" -P 'OR ("BuyerMSP.peer","BankMSP.peer")'

# stepInfo "Instantiate Contract On Peer0 Of Seller"
# INIT_CHAINCODE_PARAMETERS='{"Args":["init", "sellerBalance", "100", "buyerBalance", "100"]}'
# docker exec -it cli peer chaincode instantiate -o orderer.yunxi.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem -C $CHANNEL_NAME -n $CONTRACT_NAME -l $BUILD_LANGUAGE -v $CHAINCODE_VERSION -c "$INIT_CHAINCODE_PARAMETERS" -P 'OR ("SellerMSP.peer","BuyerMSP.peer")'

stepInfo "Sleeping for 5 seconds, waiting for chaincode instantation to complete ..."
sleep 5

stepInfo "Test Query Function for Getting Seller's Balance"
TEST_CHAINCODE_PARAMETERS='{"Args":["get","sellerBalance"]}'
docker exec -it cli \
peer chaincode query -n $CHAINCODE_NAME -c "$TEST_CHAINCODE_PARAMETERS" -C $CHANNEL_NAME1

stepInfo "Test Query Function for Getting Buyer's Balance"
TEST_CHAINCODE_PARAMETERS='{"Args":["get","buyerBalance"]}'
docker exec -it cli \
peer chaincode query -n $CHAINCODE_NAME -c "$TEST_CHAINCODE_PARAMETERS" -C $CHANNEL_NAME2

stepInfo "Test Invoke Function for Updating Seller's Balance"
INOVKE_CHAINCODE_PARAMETERS='{"Args":["update", "sellerBalance", "150"]}'
docker exec -it cli \
peer chaincode invoke -o orderer.yunxi.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem -C $CHANNEL_NAME1 -n $CHAINCODE_NAME --peerAddresses peer0.seller.yunxi.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/peers/peer0.seller.yunxi.com/tls/ca.crt -c "$INOVKE_CHAINCODE_PARAMETERS"

stepInfo "Test Invoke Function for Updating Buyer's Balance"
INOVKE_CHAINCODE_PARAMETERS='{"Args":["update", "buyerBalance", "250"]}'
docker exec -it cli \
peer chaincode invoke -o orderer.yunxi.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem -C $CHANNEL_NAME2 -n $CHAINCODE_NAME --peerAddresses peer0.buyer.yunxi.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/seller.yunxi.com/peers/peer0.seller.yunxi.com/tls/ca.crt -c "$INOVKE_CHAINCODE_PARAMETERS"

stepInfo "Sleeping for 5s to wait for data update to complete"
sleep 5

stepInfo "Test Query Function for Getting Seller's Balance again"
TEST_CHAINCODE_PARAMETERS='{"Args":["get","sellerBalance"]}'
docker exec -it cli \
peer chaincode query -n $CHAINCODE_NAME -c "$TEST_CHAINCODE_PARAMETERS" -C $CHANNEL_NAME1

stepInfo "Test Query Function for Getting Buyer's Balance again"
TEST_CHAINCODE_PARAMETERS='{"Args":["get","buyerBalance"]}'
docker exec -it cli \
peer chaincode query -n $CHAINCODE_NAME -c "$TEST_CHAINCODE_PARAMETERS" -C $CHANNEL_NAME2