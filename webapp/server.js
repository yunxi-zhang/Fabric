var express = require("express");
var connectFabricNetwork = require("./connectFabricNetwork")
var app = express(),
    port = process.env.PORT || 3000;

app.listen(port, ()=> {
    console.log("server is running on port 3000");
})

app.get("/getSellerBalance", async (req, res, next) => {
    let balance = await connectFabricNetwork.getSellerBalance();
    res.json(JSON.parse(balance));
});

app.get("/getBuyerBalance", async (req, res, next) => {
    let balance = await connectFabricNetwork.getBuyerBalance();
    res.json(JSON.parse(balance));
});

app.get("/getBuyerBalanceInExchange", async (req, res, next) => {
    let balance = await connectFabricNetwork.getBuyerBalanceInExchange();
    res.json(JSON.parse(balance));
});