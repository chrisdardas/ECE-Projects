'use strict';

const path = require('path');
const http = require('http');
const express = require('express');
const oas3Tools = require('oas3-tools');
const serverPort = 8080;
var utils = require('./utils/writer.js');

// swaggerRouter configuration
const options = {
    logging:true,
    mock: true,
    routing: {
        controllers: path.join(__dirname, './controllers')
    }
};

const expressAppConfig = oas3Tools.expressAppConfig(path.join(__dirname, 'api/openapi.yaml'), options);
const app = express();

app.get("/", (_, res, next) => {
    // res.status(201).json({message : "Success"});
    // next();
    utils.writeJson(res, {message: "Success"}, 201);
    next();
});

app.use('/search', (req, res, next) => {
    if (req.query.mockError === 'true') {
        return  res.status(500).json({ error: 'Mock Error' });//utils.writeJson(res, {error: "Mock Error"}, 500); //res.status(500).json({ error: 'Mock error' });
    }
    next(); // Pass the request to the next middleware or handler
});
const swaggerApp = expressAppConfig.getApp();

app.use(swaggerApp);
// Initialize the Swagger middleware
// Start the server only if not in a test environment
if(require.main === module){ 
    http.createServer(app).listen(serverPort, function () {
        // console.log("WHY NOT???");
        console.log('Your server2312 is listening on port %d (http://localhost:%d)', serverPort, serverPort);
        console.log('Swagger-ui is available on http://localhost:%d/docs', serverPort);
    });
}

module.exports = app;


