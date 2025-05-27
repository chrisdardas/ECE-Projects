'use strict';

/**
 * Retrieve a specific direction
 *
 * restaurantName String
 * returns Directions
 **/
exports.directionsGET = function (restaurantName) {
  return new Promise(function (resolve, _) {
    const examples = {
      Mamalouka: {
        address: 'Leoforou Stratou 34',
        id: '1',
      },
      // You can add more restaurants here if needed
    };

    // Normalize the restaurant name to ensure case-insensitive matching
    const normalizedRestaurantName = restaurantName.trim();

    // Check if the restaurant name exists in the examples
    if (examples[normalizedRestaurantName]) {
      resolve(examples[normalizedRestaurantName]);
    } else {
      // If not found, resolve with null to trigger the 404 response
      resolve(null);
    }
  });
};
