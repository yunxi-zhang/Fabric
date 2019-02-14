'use strict';

const shim = require('fabric-shim');

const Chaincode = class {

    async Init(stub) {
        let args = stub.getFunctionAndParameters().params;
        console.log(args);

        //await stub.putState(key, Buffer.from(args[0]));
        // save the initial states
        await stub.putState(key, Buffer.from('a test value'));
        return shim.success(Buffer.from('Initialised Successfully!'));
    }

    async Invoke(stub) {

        // retrieve existing chaincode states
        let oldValue = await stub.getState(key);
        let newValue = oldValue + " plus a new value";
        await stub.putState(key, Buffer.from(newValue));
        return shim.success(Buffer.from(newValue.toString()));
    }
};

shim.start(new Chaincode());