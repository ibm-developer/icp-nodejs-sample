/*
 * Licensed Materials - Property of IBM
 * (C) Copyright IBM Corp. 2018. All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*/

// Set in Dockerfile
if (process.env.USE_ZIPKIN) {
  console.log("This sample will attempt to send trace data to a Zipkin server")
  var zipkinHost = "localhost"
  var zipkinPort = 9411

  if (process.env.ZIPKIN_SERVICE_HOST && process.env.ZIPKIN_SERVICE_PORT) {
    console.log("Routing Zipkin traffic to the Zipkin Kubernetes service...")
    zipkinHost = process.env.ZIPKIN_SERVICE_HOST
    zipkinPort = process.env.ZIPKIN_SERVICE_PORT  
    console.log("Detected Zipkin host is: " + zipkinHost)
    console.log("Detected Zipkin port is: " + zipkinPort)
  } else {
    console.log("Detected we're running the Zipkin server locally")
  }

  var appzip = require('appmetrics-zipkin')({
    host: zipkinHost,
    port: zipkinPort,
    serviceName:'icp-nodejs-sample'
  });
}

// Important these are after appzip so we get the spans
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
