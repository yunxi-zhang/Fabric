'use strict';

const shim = require('fabric-shim');
const util = require('util');

const Chaincode = class {

    Init(stub) {
        console.log('========= Chaincode Initialised =========');
        return stub.putState('dummyKey', Buffer.from('dummyValue'))
            .then(() => {
                console.info('Chaincode instantiation is successful');
                return shim.success();
            }, () => {
                return shim.error();
            })
    }

    Invoke(stub) {
        console.log('========= Chaincode Invoked =========');
        // console.info('Transaction ID: ' + stub.getTxID());
        console.info(stub.getArgs());
        return shim.success();

        // let ret = stub.getFunctionAndParameters();
        // console.info('Calling function: ' + ret.fcn);

        // return stub.getState('dummyKey')
        // .then((value) => {
        //         if (value.toString() === 'dummyValue') {
        //                 console.info(util.format('successfully retrieved value "%j" for the key "dummyKey"', value ));
        //                 return shim.success();
        //         } else {
        //                 console.error('Failed to retrieve dummyKey or the retrieved value is not expected: ' + value);
        //                 return shim.error();
        //         }
        // });
    }
};

shim.start(new Chaincode());