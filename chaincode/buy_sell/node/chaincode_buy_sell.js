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
        console.info(stub.getArgs());

        return stub.getState('dummyKey')
            .then((value) => {
                if (value.toString() === 'dummyValue') {
                        console.info(value.toString());
                        return shim.success();
                } else {
                        console.error('Failed to retrieve dummyKey or the retrieved value is not expected: ' + value);
                        return shim.error();
                }
            });
    }
};

shim.start(new Chaincode());