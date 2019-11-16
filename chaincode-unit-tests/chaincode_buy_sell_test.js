const chaincode_batches = require('./chaincode_buy_sell');
const {
    ChaincodeMockStub,
    Transform
} = require('@theledger/fabric-mock-stub');
const chai = require('chai');
const expect = chai.expect;
const chaincode = new chaincode_batches();

describe('Test buy_sell chaincode', () => {
    it('get balance in the ledger should succeed', async() =>{
        // instantiate a new mock stub
        const mockStub = new ChaincodeMockStub('MyMockStub', chaincode);
        // call mockInit to put the batches to the ledger
        await mockStub.mockInit('tx1', ["init","sellerBalance", "100"]);
        let response = await mockStub.mockInvoke('tx1', ['getBalance','sellerBalance']);
        expect(Transform.bufferToObject(response.payload)).to.eql(100);
    });
});