'use strict';

var utils = require('../utils/writer.js');
var Search = require('../service/SearchService');

module.exports.searchGET = function searchGET (req, res, next) {
  const mockError = req.query.mockError === 'true';
  console.log('Mock Error Enabled: ', mockError);
  if(mockError)
  {
    return res.status(500).json({error : 'Mock error'});
    // utils.writeJson(res, {message: 'Mock error'}, 500);
  }
  Search.searchGET(req)
    .then(function (response) {
      // console.log('Controller: Sending Respose:', response);
      // console.log(req);
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (error) {
      console.error('Controller: Error occurred:', error);
      utils.writeJson(res, {error: "Server Error"}, 500);
      //res.status(500).json({error: 'Server Error'});
    });
    next();
};
