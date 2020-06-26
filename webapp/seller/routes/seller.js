var express = require('express');
var router = express.Router();
var money = require('../money/money');
router.use(express.json());

router.get("/balance", async (req, res, next) => {
    let balance = await money.getSellerBalance();
    res.json({"balance":balance});
});

module.exports = router;