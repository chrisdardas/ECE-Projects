'use strict';

var utils = require('../utils/writer.js');
var Directions = require('../service/DirectionsService');

module.exports.directionsGET = function directionsGET(_, res, next, restaurantName) {
  Directions.directionsGET(restaurantName)
    .then(function (response) {
      if (!response) {
        // If no response, return an error message with a 404 status code
        utils.writeJson(res, { message: 'Directions not found' }, 404);
      } else {
        // If found, return the directions
        utils.writeJson(res, response);
      }
    })
    .catch(function (_) {
      // Handle any internal errors
      utils.writeJson(res, { message: 'Internal server error' }, 500);
    });
    next();
};
