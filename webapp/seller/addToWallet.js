'use strict';

const fs = require('fs');
const { FileSystemWallet, X509WalletMixin } = require('fabric-network');
const path = require('path');
let sellerDirectoryPath;

// Get the path of each organisation directory that contains private key
try {
    sellerDirectoryPath = path.join(__dirname, '../../crypto-config/peerOrganizations/seller.admincom/users/Admin@seller.admincom/msp/keystore/');
} catch (e) {
    console.log("Error in getting private key path in addToWallet.js", e);
}
// Use the path to get the file name of the private key for each organisation
const sellerPrivateKey = fs.readdirSync(sellerDirectoryPath)[0];

async function sellerIdentityInit() {
    // A wallet stores a collection of identities for users in seller to use
    const wallet = new FileSystemWallet('./wallet');
    const credPath = path.resolve(__dirname, '../../crypto-config/peerOrganizations/seller.admincom/users/Admin@seller.admincom');
    // Identity to credentials to be stored in the wallet
    const cert = fs.readFileSync(path.join(credPath, '/msp/signcerts/Admin@seller.admincom-cert.pem')).toString();
    const key = fs.readFileSync(path.join(credPath, '/msp/keystore/' + sellerPrivateKey)).toString();
    const identityLabel = 'Admin@seller.admincom';
    const identity = X509WalletMixin.createIdentity('SellerMSP', cert, key);
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

sellerIdentityInit().then(() => {
    console.log('seller\'s wallet has been initilised succesfully');
}).catch((e) => {
    console.log('Caught exception when initialising seller\'s wallet');
    console.log(e);
    console.log(e.stack);
    process.exit(-1);
});