'use strict';

const fs = require('fs');
const yaml = require('js-yaml');
const { Gateway } = require('fabric-network');
const CONNECTION_PROFILE_PATH = './config/ConnectionProfile.yml';
const UTF8 = 'utf8';

// A gateway defines the peers used to access Fabric networks
const gateway = new Gateway();

async function setupConnection(userName, wallet) {
    try{
        const connectionProfile = yaml.safeLoad(fs.readFileSync(CONNECTION_PROFILE_PATH, UTF8));
        let connectionOptions = {
            identity: userName,
            wallet: wallet,
            discovery: { enabled: false, asLocalhost: true}
        };
        return [connectionProfile, connectionOptions];
    } catch (error) {
        console.log('Error processing transaction.', error);
    } finally {
        // Disconnect from the gateway
        console.log('Disconnect from Fabric gateway.')
        gateway.disconnect();
    }     
}

module.exports = {
    setupConnection
}; 