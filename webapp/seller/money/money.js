'use strict';

const path = require('path');
const { Gateway, FileSystemWallet } = require('fabric-network');
const connectionFabricNetwork = require('../../connectFabricNetwork');
const sellerUserName = 'Admin@seller.yunxi.com';
const SELLER_WALLET_PATH = path.resolve(__dirname, '../wallet');
const sellerWallet = new FileSystemWallet(SELLER_WALLET_PATH);
const CHANNEL_NAME2 = 'channel-seller';
const CHAINCODE_NAME = 'cc';
const CHAINCODE_QUERY_FUNCTION_NAME = 'get';
const SELLER_BALANCE_QUERY_KEY = 'sellerBalance';

// A gateway defines the peers used to access Fabric networks
const gateway = new Gateway();

async function getSellerBalance(){
    try {
        const connection = await connectionFabricNetwork.setupConnection(sellerUserName, sellerWallet);
        // Connect to gateway using application specified parameters
        console.log('Connecting to Fabric gateway...');
        await gateway.connect(connection[0], connection[1]);

        const network = await gateway.getNetwork(CHANNEL_NAME2);
        console.log('Use channel:', network.channel._name);
    
        const contract = await network.getContract(CHAINCODE_NAME);
        console.log('Use chaincode:', contract.chaincodeId);
    
        const queryResponse = await contract.evaluateTransaction(CHAINCODE_QUERY_FUNCTION_NAME, SELLER_BALANCE_QUERY_KEY);
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
    getSellerBalance
}; 