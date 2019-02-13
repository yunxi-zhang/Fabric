#!/bin/bash
echo -e "\x1b[33mCreate A Channel And Join The Channel \x1b[0m "
docker exec -it cli peer channel create -o orderer.yunxi.com:7050 -c $CHANNELNAME -f ./channel-artifacts/channel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/yunxi.com/orderers/orderer.yunxi.com/msp/tlscacerts/tlsca.yunxi.com-cert.pem
docker exec -it cli peer channel join -b $CHANNELNAME.block