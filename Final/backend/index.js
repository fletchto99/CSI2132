#!/usr/bin/env node

var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var postgres = require('pg');


var database = new postgres.Client({
    host: 'localhost',
    port: 5432,
    database: 'test'
});
database.connect();

database.query('SET search_path=sailors');

app.get('/sailors/:sailor_id', function(request, response) {
    database.query("SELECT * FROM sailors WHERE sid = $1", [request.params.sailor_id], function(error, result) {
        if (!error) {
            response.json(result.rows[0]);
        }
    });
});

app.listen(8080);