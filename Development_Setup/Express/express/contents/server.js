'use strict';
// express,bodyParser読み込み
// https://expressjs.com/ja/guide/routing.html
const express = require('express');
const bodyParser = require('body-parser');


// express起動
const PORT = 8040;
const HOST = '0.0.0.0';
const app = express();

// urlencoded,jsonパース
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

// アプリケーション
app.get('/', (req, res) => {
    res.send('This is Sample API.');
});

//関数読み込み
var functions = require("./functions");
// GET
app.get('/api', functions.get);
// POST
app.post('/api', functions.post);
// PUT
app.put('/api', functions.put);
// POST
app.delete('/api', functions.delete);

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);