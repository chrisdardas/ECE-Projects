'use strict';

var utils = require('../utils/writer.js');
var Reservations = require('../service/ReservationsService');

// module.exports.cancelReservation = function cancelReservation (req, res, next, id) {
//   Reservations.cancelReservation(id)
//     .then(function (response) {
//       utils.writeJson(res, response);
//     })
//     .catch(function (response) {
//       utils.writeJson(res, response);
//     });
// };

module.exports.cancelReservation = function cancelReservation(_, res, next, id) {
  Reservations.cancelReservation(id)
    .then(function(response) {
      if (response) {
        res.status(204).send(); // Success: No content
      } else {
        utils.writeJson(res, { error: 'Reservation not found' }, 404); // Not found
      }
    })
    .catch(function(response) {
      utils.writeJson(res, { error: response.message }, response.statusCode || 500); // Handle errors
    });
    next();
};




module.exports.listReservations = function listReservations(req, res) {
  const restaurantName = req.query.restaurantName; // Ανάκτηση του restaurantName από τα query parameters
  Reservations.listReservations(restaurantName)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (error) {
      utils.writeJson(res, { message: error.message || 'Internal server error' }, 500);
    });
};


module.exports.makeReservation = function makeReservation(_, res, next, body, restaurantName) {
  // Ensure the restaurant name exists in the query
  if (!restaurantName) {
      utils.writeJson(res, { message: 'Restaurant name is required' }, 400);
      return;
  }

  Reservations.makeReservation(body, restaurantName)
      .then(function (response) {
          utils.writeJson(res, response, 201);
      })
      .catch(function (error) {
          utils.writeJson(res, { message: error.message || 'Internal server error' }, error.statusCode || 500);
      });
      next();
};

module.exports.getReservation = function getReservation(_, res, next, id, restaurantName) {
  Reservations.getReservation(id, restaurantName)
      .then(function (response) {
          utils.writeJson(res, response);
      })
      .catch(function (error) {
          utils.writeJson(res, { message: error.message || 'Internal server error' }, error.statusCode || 500);
      });
      next();
};



module.exports.updateReservation = function updateReservation (_, res, next, body, id) {
  Reservations.updateReservation(body, id)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
    next();
};
