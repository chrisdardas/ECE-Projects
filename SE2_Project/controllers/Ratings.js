'use strict';
/**
 * This module serves as the controller for handling `Ratings`-related API endpoints.
 * It delegates the processing logic to the `RatingsService` and uses `utils/writer.js` for 
 * formatting and sending responses to the client.
 */ 
var utils = require('../utils/writer.js');
var Ratings = require('../service/RatingsService');

/**
 * GET /ratings
 * Fetches all ratings for a specific restaurant.
 */
module.exports.ratingsGET = function ratingsGET(_, res, next, restaurant_name) {
  Ratings.ratingsGET(restaurant_name)
    .then(function(response) {
      utils.writeJson(res, response);
    })
    .catch(function(response) {
      utils.writeJson(res, { error: response.message }, response.statusCode || 500);
    });
    next();
};

/**
 * DELETE /ratings/:id
 * Deletes a specific rating by its ID.
 */
module.exports.ratingsIdDELETE = function ratingsIdDELETE(_, res, next, id) {
  Ratings.ratingsIdDELETE(id)
    .then(function(response) {
      if (!response) {
        // If no record was found, respond with 404
        utils.writeJson(res, { error: 'Rating not found' }, 404);
      } else {
        // If deleted successfully, respond with 204 No Content
        res.status(204).send();
      }
    })
    .catch(function(response) {
      utils.writeJson(res, { error: response.message }, response.statusCode || 500);
    });
    next();
};

/**
 * GET /ratings/:id
 * Fetches the details of a specific rating by its ID and restaurant name.
 */
module.exports.ratingsIdGET = function ratingsIdGET(_, res, next, restaurant_name, id) {
  //console.log('Controller params:', { id, restaurant_name });
  Ratings.ratingsIdGET(id, restaurant_name)
    .then(function(response) {
      utils.writeJson(res, response);
    })
    .catch(function(response) {
      utils.writeJson(res, { error: response.message }, response.statusCode || 500);
    });
    next();
};

/**
 * PUT /ratings/:id
 * Updates an existing rating by its ID and restaurant name.
 */
module.exports.ratingsIdPUT = function ratingsIdPUT(_, res, next, body, restaurant_name, id) {
  Ratings.ratingsIdPUT(body, restaurant_name, id)
    .then(function(response) {
      utils.writeJson(res, response);
    })
    .catch(function(response) {
      utils.writeJson(res, { error: response.message }, response.statusCode || 500);
    });
    next();
};

/**
 * POST /ratings
 * Creates a new rating for the restaurant "Mamalouka".
 */
module.exports.ratingsPOST = function ratingsPOST(_, res, next, body) {
  const restaurant_name = 'Mamalouka'; // Hardcoded value
  // console.log('Received Body in Controller:', body);

  Ratings.ratingsPOST(body, restaurant_name)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (err) {
      console.error('Error in Controller:', err);
      utils.writeJson(res, { message: err.message }, err.statusCode || 500);
    });
    next();
};

//test