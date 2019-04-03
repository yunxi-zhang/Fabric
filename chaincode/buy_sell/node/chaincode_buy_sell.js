'use strict';

const shim = require('fabric-shim');
const util = require('util');

const Chaincode = class {

    // async Init(stub) {
    //     console.log('========= Chaincode Initialised =========');
    //     let ret = stub.getFunctionAndParameters();
    //     let args = ret.params;
    //     console.log("args[0]" + args[0]);
    //     console.log("args[1]" + args[1]);
    //     console.log("args[2]" + args[2]);
    //     console.log("args[3]" + args[3]);

    //     await stub.putState(args[0], Buffer.from(args[1]));
    //     await stub.putState(args[2], Buffer.from(args[3]));

    //     return shim.success();
    // }

    Init(stub) {
        console.log('========= Chaincode Initialised =========');
        console.info(stub.getArgs());
        const args = stub.getArgs();

        return stub.putState(args[1], Buffer.from(args[2]))
            .then(() => {
                return stub.getState(args[1])
                    .then((value) => {
                        console.log('initialised phase:args[1]');
                        console.log('args[1] value is:' + value.toString());
                    })
            })
            .then(() => {
                stub.putState(args[3], Buffer.from(args[4]))
            })
            .then(() => {
                console.info('Chaincode instantiation is successful');
                return shim.success();
            }, () => {
                return shim.error();
            });
    }

    // async Invoke(stub) {
    //     console.log('========= Chaincode Invoked =========');
    //     let ret = stub.getFunctionAndParameters();
    //     let fcn = this[ret.fcn];
    //     fcn(stub, ret.params);
    // }

    Invoke(stub) {
        console.log('========= Chaincode Invoked =========');
        const args = stub.getFunctionAndParameters();
        console.info(args);
        console.log('args.params[0]:' + args.params[0]);
       
        let method = this[args.fcn];
        if (!method) {
            console.log('no method of name:' + method + ' found');
        } else {
            console.log('method found');
        }

        return method(stub, args.params)
            .then (() => {
                console.log("running invoke function");
                return shim.success();
            })
            .catch(error => {
                console.error(error.toString());
                return shim.error();
            });
    }

    get(stub, args) {
        console.log('========= Get Function =========');
        console.log(args);

        return stub.getState(args[0])
            .then((value) => {
                if (value.toString() !== null ) {
                    console.info("value is:" + value.toString());
                    return 'args[0] value in the get function:' + value.toString();
                } else {
                    console.error('Failed to retrieve a value or the retrieved value is not expected: ' + value);
                    return shim.error();
                }
            });
    }

    // async update(stub, args) {
    //     console.log('========= Update Function =========');
    //     console.log(args);
    //     console.log("args[0]:" + args[0]);
    //     console.log("args[1]:" + args[1]);

    //     await stub.putState(args[0], Buffer.from(args[1]));
    //     return shim.success();
    // }

    update(stub, args) {
        console.log('========= Update Function =========');
        console.log(args);
        console.log("args[0]:" + args[0]);
        console.log("args[1]:" + args[1]);

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