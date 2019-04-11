'use strict';

const fs = require('fs');
const yaml = require('js-yaml');
const { Gateway, FileSystemWallet } = require('fabric-network');
const sellerWallet = new FileSystemWallet('./identity/user/seller/wallet');
const buyerWallet = new FileSystemWallet('./identity/user/buyer/wallet');
const sellerUserName = 'Admin@seller.yunxi.com';
const buyerUserName = 'Admin@buyer.yunxi.com';
const CONNECTION_PROFILE_PATH = './config/ConnectionProfile.yml';
const UTF8 = 'utf8';
const CHANNEL_NAME = 'c1';
const CHAINCODE_NAME = 'cc';
const CHAINCODE_QUERY_FUNCTION_NAME = 'get';
const CHAINCODE_QUERY_KEY = 'row1';

// A gateway defines the peers used to access Fabric networks
const gateway = new Gateway();
    
async function getSellerBalance(){
    try {
        const connectionProfile = yaml.safeLoad(fs.readFileSync(CONNECTION_PROFILE_PATH, UTF8));
        let connectionOptions = {
            identity: sellerUserName,
            wallet: sellerWallet,
            discovery: { enabled: false, asLocalhost: true}
        };
        // Connect to gateway using application specified parameters
        console.log('Connecting to Fabric gateway...');
        await gateway.connect(connectionProfile, connectionOptions);

        const network = await gateway.getNetwork(CHANNEL_NAME);
        console.log('Use channel:', network.channel._name);
    
        const contract = await network.getContract(CHAINCODE_NAME);
        console.log('Use chaincode:', contract.chaincodeId);
    
        const queryResponse = await contract.evaluateTransaction(CHAINCODE_QUERY_FUNCTION_NAME, CHAINCODE_QUERY_KEY);
        return queryResponse.toString();
    } catch (error) {
        console.log(`Error processing transaction. ${error}`);
        console.log(error.stack);
    } finally {
        // Disconnect from the gateway
        console.log('Disconnect from Fabric gateway.')
        gateway.disconnect();
    }    
}

async function getBuyerBalance(){
    try {
        const connectionProfile = yaml.safeLoad(fs.readFileSync(CONNECTION_PROFILE_PATH, UTF8));
        let connectionOptions = {
            identity: buyerUserName,
            wallet: buyerWallet,
            discovery: { enabled: false, asLocalhost: true}
        };
        // Connect to gateway using application specified parameters
        console.log('Connecting to Fabric gateway...');
        await gateway.connect(connectionProfile, connectionOptions);

        const network = await gateway.getNetwork(CHANNEL_NAME);
        console.log('Use channel:', network.channel._name);
    
        const contract = await network.getContract(CHAINCODE_NAME);
        console.log('Use chaincode:', contract.chaincodeId);
    
        const queryResponse = await contract.evaluateTransaction(CHAINCODE_QUERY_FUNCTION_NAME, CHAINCODE_QUERY_KEY);
        return queryResponse.toString();
    } catch (error) {
        console.log(`Error processing transaction. ${error}`);
        console.log(error.stack);
    } finally {
        // Disconnect from the gateway
        console.log('Disconnect from Fabric gateway.')
        gateway.disconnect();
    }    
}

module.exports = {
    getSellerBalance,
    getBuyerBalance
}; 