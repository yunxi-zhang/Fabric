var express = require("express");
var app = express(),
    port = 3001;
const bank = require('./bank/routes/bank.js');

app.use('/bank', bank);
app.use(express.json());

app.listen(port, ()=> {
    console.log("server is running on port ", port);
})