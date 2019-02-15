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

# Golang uses a relative path, and the ABSOLUTE_PATH_PREFIX will be auto added to the CHAINCODE_PATH
# ABSOLUTE_PATH_PREFIX is only used when node or java has been selected as the build language
ABSOLUTE_PATH_PREFIX="/opt/gopath/src"
CHAINCODE_PATH="github.com/chaincode/buy_sell"

stepInfo "Install Chaincode On Peer0 Of Seller"
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

stepInfo "Run Chaincode on node"
#docker exec -it cli CORE_CHAINCODE_ID_NAME=$CHAINCODE_NAME:$CHAINCODE_VERSION node chaincode_buy_sell.js --peer.address grpc://peer0.seller.yunxi.com:7051

stepInfo "Instantiate Chaincode"
docker exec -it cli peer chaincode instantiate -o orderer.yunxi.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem -C $CHANNEL_NAME -n $CHAINCODE_NAME -l $BUILD_LANGUAGE -v $CHAINCODE_VERSION -c '{"Args":["init"]}' -P "AND ('SellerMSP.peer','BuyerMSP.peer')"
