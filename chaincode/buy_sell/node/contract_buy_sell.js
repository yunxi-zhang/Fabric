'use strict';

const { Contract } = require('fabric-contract-api');
const util = require('util');

class BuySellContract extends Contract {
    
    constructor() {
        super('BuySellContract');
    }

    async buy(ctx, newValue) {
        let oldValue = await ctx.stub.getState(key);
        await ctx.stub.putState(key, Buffer.from(newValue));
        return Buffer.from(newValue.toString());
    } 
};

module.exports = BuySellContract;