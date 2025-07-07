'use strict';

var utils = require('../utils/writer.js');
var Preorder = require('../service/PreorderService');

module.exports.preOrderGET = function preOrderGET (_, res) {
  Preorder.preOrderGET()
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};

module.exports.preOrderIdDELETE = function preOrderIdDELETE(_, res, next, id) {
  Preorder.preOrderIdDELETE(id)
    .then(function () {
      res.status(204).end(); // Return 204 No Content on success
    })
    .catch(function (response) {
      utils.writeJson(res, response, response.status || 500);
    });
    next();
};

module.exports.preOrderIdGET = function preOrderIdGET(_, res, next, restaurant_name, id) {
  Preorder.preOrderIdGET(id, restaurant_name)
      .then(function (response) {
          utils.writeJson(res, response); // Send the preorder as the response
      })
      .catch(function (error) {
          if (error.message === 'Preorder not found') {
              // If the error is a "Preorder not found", send a 404 response
              utils.writeJson(res, { message: error.message }, 404);
          } else {
              // For any other errors, send a 500 Internal Server Error response
              utils.writeJson(res, { message: 'Internal server error' }, 500);
          }
      });
      next();
};


module.exports.preOrderIdPUT = function preOrderIdPUT(req, res, next, _, restaurant_name, id) {
  // console.log('req.params:', req.params); // Log the params for debugging
  // console.log('req.query:', req.query);   // Log the query for debugging
  // console.log('req.body:', req.body);     // Log the body for debugging
  console.log('restaurant_name:', restaurant_name); // Log the restaurant_name for debugging
  console.log('id:', id); // Log the id for debugging

  Preorder.preOrderIdPUT(req.body,restaurant_name,id)
      .then(function (response) {
          utils.writeJson(res, response);
      })
      .catch(function (response) {
          utils.writeJson(res, response, response.status || 500);
      });
      next();
};


module.exports.preOrderPOST = function preOrderPOST(_, res, next, body = {}) {
  const { price, name, id, restaurant_name } = body;

  // Validate required fields
  const missingFields = [];
  if (price == null) missingFields.push('price');
  if (name == null) missingFields.push('name');
  if (id == null) missingFields.push('id');
  if (restaurant_name == null) missingFields.push('restaurant_name');

  if (missingFields.length > 0) {
    const error = { message: `Missing required field(s): ${missingFields.join(' ')}` };
    console.error('Error in preOrderPOST:', error);
    return utils.writeJson(res, error, 400);
  }

  // Check for duplicates and create preorder
  Preorder.checkDuplicate(id, restaurant_name)
    .then((isDuplicate) => {
      if (isDuplicate) {
        return utils.writeJson(res, { message: `Duplicate preorder with ID ${id} and restaurant_name ${restaurant_name}` }, 400);
      }

      // If no duplicate, proceed to create the preorder
      return Preorder.preOrderPOST(body).then((response) => {
        utils.writeJson(res, response, 200); // 201 Created
      });
    })
    .catch((error) => {
      console.error('Error in preOrderPOST:', error);
      utils.writeJson(res, { message: error.message }, error.statusCode || 500);
    });
    next();
};

