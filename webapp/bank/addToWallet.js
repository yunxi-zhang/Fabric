'use strict';

const fs = require('fs');
const { FileSystemWallet, X509WalletMixin } = require('fabric-network');
const path = require('path');
let bankDirectoryPath;

// Get the path of each organisation directory that contains private key
try {
    bankDirectoryPath = path.join(__dirname, '../../crypto-config/peerOrganizations/bank.yunxi.com/users/Admin@bank.yunxi.com/msp/keystore/');
} catch (e) {
    console.log("Error in getting private key path in addToWallet.js", e);
}
// Use the path to get the file name of the private key for each organisation
const bankPrivateKey = fs.readdirSync(bankDirectoryPath)[0];

async function bankIdentityInit() {
    // A wallet stores a collection of identities for users in bank to use
    const wallet = new FileSystemWallet('./wallet');
    const credPath = path.resolve(__dirname, '../../crypto-config/peerOrganizations/bank.yunxi.com/users/Admin@bank.yunxi.com');
    // Identity to credentials to be stored in the wallet
    const cert = fs.readFileSync(path.join(credPath, '/msp/signcerts/Admin@bank.yunxi.com-cert.pem')).toString();
    const key = fs.readFileSync(path.join(credPath, '/msp/keystore/' + bankPrivateKey)).toString();
    const identityLabel = 'Admin@bank.yunxi.com';
    const identity = X509WalletMixin.createIdentity('BankMSP', cert, key);
    createIdentity(wallet, identityLabel, identity)
}

async function createIdentity(wallet, identityLabel, identity) {
    try {
        // Load credentials into wallet
        await wallet.import(identityLabel, identity);

    } catch (error) {
        console.log(`Error adding to wallet. ${error}`);
        console.log(error.stack);
    }
}

bankIdentityInit().then(() => {
    console.log('bank\'s wallet has been initilised succesfully');
}).catch((e) => {
    console.log('Caught exception when initialising bank\'s wallet');
    console.log(e);
    console.log(e.stack);
    process.exit(-1);
});