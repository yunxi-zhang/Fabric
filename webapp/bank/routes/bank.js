var express = require('express');
var router = express.Router();
var money = require('../money/money');
router.use(express.json());

router.get("/getSellerBalance", async (req, res, next) => {
    let balance = await money.getSellerBalance();
    res.json(JSON.parse(balance));
});

router.get("/getBuyerBalance", async (req, res, next) => {
    let balance = await money.getBuyerBalance();
    res.json(JSON.parse(balance));
});

module.exports = router;