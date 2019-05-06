var express = require('express');
var router = express.Router();
var money = require('../money/money');
router.use(express.json());

router.get("/getBalance", async (req, res, next) => {
    let balance = await money.getBuyerBalance();
    res.json(JSON.parse(balance));
});

module.exports = router;