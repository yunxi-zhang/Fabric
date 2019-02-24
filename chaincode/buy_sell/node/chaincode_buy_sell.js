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
        const args = stub.getFunctionAndParameters();
        console.info(args);
        let method = this[args.fcn];
        if (!method) {
            console.log('no method of name:' + method + ' found');
            return 'no method of name:' + method + ' found';
        }

        try {
            let payload = await method(stub, args.params);
            return shim.success(payload);
        } catch (err) {
            console.log(err);
            return shim.error(err);
        }
    }

    get(stub, args) {
        console.log('========= Get Function =========');
        console.log(args);

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

    update(stub, args) {
        console.log('========= Update Function =========');
        console.log(args);

        return stub.putState(args[0], Buffer.from(args[1]))
            .then(() => {
                console.info('Chaincode update is successful');
                return shim.success();
            }, () => {
                return shim.error();
            });
    }

    delete(stub,args) {
        console.log('========= Delete Function =========');
    }
};

shim.start(new Chaincode());