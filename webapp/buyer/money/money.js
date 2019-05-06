'use strict';

const path = require('path');
const { Gateway, FileSystemWallet } = require('fabric-network');
const connectionFabricNetwork = require('../../connectFabricNetwork');
const buyerUserName = 'Admin@buyer.yunxi.com';
const BUYER_WALLET_PATH = path.resolve(__dirname, '../wallet');
const buyerWallet = new FileSystemWallet(BUYER_WALLET_PATH);
const CHANNEL_NAME2 = 'channel-buyer';
const CHAINCODE_NAME = 'cc';
const CHAINCODE_QUERY_FUNCTION_NAME = 'get';
const BUYER_BALANCE_QUERY_KEY = 'buyerBalance';

// A gateway defines the peers used to access Fabric networks
const gateway = new Gateway();

async function getBuyerBalance(){
    try {
        const connection = await connectionFabricNetwork.setupConnection(buyerUserName, buyerWallet);
        // Connect to gateway using application specified parameters
        console.log('Connecting to Fabric gateway...');
        await gateway.connect(connection[0], connection[1]);

        const network = await gateway.getNetwork(CHANNEL_NAME2);
        console.log('Use channel:', network.channel._name);
    
        const contract = await network.getContract(CHAINCODE_NAME);
        console.log('Use chaincode:', contract.chaincodeId);
    
        const queryResponse = await contract.evaluateTransaction(CHAINCODE_QUERY_FUNCTION_NAME, BUYER_BALANCE_QUERY_KEY);
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
    getBuyerBalance
}; 