'use strict';

const shim = require('fabric-shim');
const util = require('util');

const Chaincode = class {

    async Init(stub) {
        // let args = stub.getFunctionAndParameters().params;
        // console.log(args);

        // // save the initial states
        // return stub.putState('dummykey', Buffer.from('dummyValue'))
        //             .then(() => {
        //                 console.info('Chaincode instantiation is successful');
        //                 return shim.success();
        //             }), () => {
        //                 return shim.error();
        //             };
        console.log('========= Chaincode Initialised =========');
        const ret = stub.getFunctionAndParameters();
        console.log(ret);
        return shim.success();
    }

    async Invoke(stub) {
        console.info('Transaction ID: ' + stub.getTxID());
        console.info(util.format('Args: %j', stub.getArgs()));

        let ret = stub.getFunctionAndParameters();
        console.info('Calling function: ' + ret.fcn);
        return stub.getState('dummyKey')
            .then((value) => {
                if (value.toString === 'dummyValue') {
                    console.info(util.format('successfully retrieved value "%j" for the key "dummyKey"', value));
                    return shim.success();
                } else {
                    console.error('Failed to retrieve dummyKey or the retrieved value is not expected: ' + value);
                    return shim.error();
                }
            })
    }
};

shim.start(new Chaincode());