'use strict';

var utils = require('../utils/writer.js');
var Reviews = require('../service/ReviewsService');

module.exports.reviewsGET = function reviewsGET(_, res, next, restaurantName) {
  // Call the service function and pass the restaurantName parameter
  Reviews.reviewsGET(restaurantName)
    .then(function (response) {
      utils.writeJson(res, response); // Respond with the filtered reviews
    })
    .catch(function (response) {
      utils.writeJson(res, response); // Handle any errors
    });
    next();
};
