var express = require('express');
var router = express.Router();
var money = require('../money/money');
router.use(express.json());

router.get("/getBalance", async (req, res) => {
    let balance = await money.getBuyerBalance();
    res.json(JSON.parse(balance));
});


router.post("/updateBalance", async (req, res) => {
    // req.body should look like
    // {
    //     "key": "xBalance",
    //     "value": "20"
    // }
    let userInput = JSON.stringify(req.body);
    let transactionID = await money.updateBuyerBalance(userInput);
    res.json({status: 'success', transactionId: transactionID});
});

module.exports = router;