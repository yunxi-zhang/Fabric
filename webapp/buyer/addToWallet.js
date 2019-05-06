'use strict';

const fs = require('fs');
const { FileSystemWallet, X509WalletMixin } = require('fabric-network');
const path = require('path');
let buyerDirectoryPath;

// Get the path of each organisation directory that contains private key
try {
    buyerDirectoryPath = path.join(__dirname, '../../crypto-config/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com/msp/keystore/');
} catch (e) {
    console.log("Error in getting private key path in addToWallet.js", e);
}
// Use the path to get the file name of the private key for each organisation
const buyerPrivateKey = fs.readdirSync(buyerDirectoryPath)[0];

async function buyerIdentityInit() {
    // A wallet stores a collection of identities for users in buyer to use
    const wallet = new FileSystemWallet('./wallet');
    const credPath = path.resolve(__dirname, '../../crypto-config/peerOrganizations/buyer.yunxi.com/users/Admin@buyer.yunxi.com');
    // Identity to credentials to be stored in the wallet
    const cert = fs.readFileSync(path.join(credPath, '/msp/signcerts/Admin@buyer.yunxi.com-cert.pem')).toString();
    const key = fs.readFileSync(path.join(credPath, '/msp/keystore/' + buyerPrivateKey)).toString();
    const identityLabel = 'Admin@buyer.yunxi.com';
    const identity = X509WalletMixin.createIdentity('BuyerMSP', cert, key);
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

buyerIdentityInit().then(() => {
    console.log('buyer\'s wallet has been initilised succesfully');
}).catch((e) => {
    console.log('Caught exception when initialising buyer\'s wallet');
    console.log(e);
    console.log(e.stack);
    process.exit(-1);
});