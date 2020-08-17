var express = require("express");
var app = express(),
    port = 3002;
const buyer = require('./buyer/routes/buyer.js');

app.use('/', buyer);
app.use(express.json());

app.listen(port, ()=> {
    console.log("server is running on port ", port);
})