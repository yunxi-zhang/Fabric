'use strict';

const { Contract } = require('fabric-contract-api');
const util = require('util');

class ExchangeContract extends Contract {
    
    constructor() {
        super('ExchangeContract');
    }

    async getInExchange(ctx, key) {
        let valueBuffer = await ctx.stub.getState(key);
        let valueString = valueBuffer.toString();
        console.log('value:', valueString);
        return valueString;
    } 
};

module.exports = ExchangeContract;