/*
 * Licensed Materials - Property of IBM
 * (C) Copyright IBM Corp. 2017. All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*/

require('appmetrics-dash').attach();
require('appmetrics-prometheus').attach();

const appName = require('./../package').name;
const express = require('express');
const log4js = require('log4js');
const localConfig = require('./config/local.json');

const logger = log4js.getLogger(appName);
const app = express();
require('./services/index')(app);
require('./routers/index')(app);

app.set('view engine', 'ejs');

app.get('/create', function(req, res) {
  res.render('create')
});

app.get('/deploy', function(req, res) {
  res.render('deploy')
});

app.get('/monitor', function(req, res) {
  res.render('monitor')
});

app.get('/', function(req, res) {
  res.render('index')
});

const port = process.env.PORT || localConfig.port;
app.listen(port, function(){
	logger.info(`Node.js sample listening on http://localhost:${port}`);

});
