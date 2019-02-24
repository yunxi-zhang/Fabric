'use strict';

const shim = require('fabric-shim');
const util = require('util');

const Chaincode = class {

    Init(stub) {
        console.log('========= Chaincode Initialised =========');
        console.info(stub.getArgs());
        const args = stub.getArgs();
        return stub.putState(args[1], Buffer.from(args[2]))
            .then(() => {
                stub.putState(args[3], Buffer.from(args[4]))
            })
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

        return stub.getState('sellerBalance')
            .then((value) => {
                if (value.toString() !== null ) {
                        console.info(value.toString());
                        return shim.success();
                } else {
                        console.error('Failed to retrieve a value or the retrieved value is not expected: ' + value);
                        return shim.error();
                }
            });
    }

    query(stub, args) {
        console.log('========= Chaincode Queried =========');
        console.info(args);

        return stub.getState(args[0])
            .then((value) => {
                if (value.toString() !== null ) {
                        console.info(value.toString());
                        return value.toString();
                } else {
                        console.error('Failed to retrieve a value or the retrieved value is not expected: ' + value);
                        return shim.error();
                }
            });
    }
};

shim.start(new Chaincode());