'use strict';

/**
 * Retrieve a list of ratings
 *
 * restaurant_name String 
 * returns List
 **/

exports.ratingsGET = function (restaurant_name) {
  return new Promise(function (resolve, reject) {
    if (!restaurant_name) {
      reject({ statusCode: 400, message: 'Restaurant name is required' });
      return;
    }

    // Example data, this would typically come from a database
    var examples = [
      {
        "user_id": "user32",
        "rating": 4.5,
        "restaurant_name": "mamalouka"
      },
      {
        "user_id": "user33",
        "rating": 4.0,
        "restaurant_name": "mamalouka"
      }
    ];

    // Filter ratings by restaurant_name
    const filteredRatings = examples.filter(
      (rating) => rating.restaurant_name.toLowerCase() === restaurant_name.toLowerCase()
    );

    if (filteredRatings.length > 0) {
      // Resolve with the filtered ratings
      resolve(filteredRatings);
    } else {
      // Reject with an error if no ratings found for the restaurant
      reject({ statusCode: 404, message: 'Rating not found' });
    }
  });
};
/**
 * Delete a rating
 *
 * id String 
 * no response value expected for this operation
 **/
// exports.ratingsIdDELETE = function(id) {
//   return new Promise(function(resolve, reject) {
//     if (!id) {
//       reject({ statusCode: 400, message: 'ID is required' });
//       return;
//     }

//     // Simulate successful deletion (in real use, this would interact with a database)
//     resolve();
//   });
// };

exports.ratingsIdDELETE = function(id) {
  return new Promise(function(resolve, reject) {
    if (!id) {
      reject({ statusCode: 400, message: 'ID is required' });
      return;
    }

    // Simulate database check for ID existence
    const database = { user32: { user_id: "user32", rating: 4.5, restaurant_name: "TestRestaurant" } }; // Example mock DB

    if (database[id]) {
      // Simulate deletion from the database
      delete database[id];
      resolve(true); // Record was successfully deleted
    } else {
      resolve(false); // Record not found
    }
  });
};

exports.ratingsIdGET = function (id, restaurant_name) {
  return new Promise(function (resolve, reject) {
    // Define example data with proper structure
    const examples = {
      "user32": {
        user_id: "user32",
        rating: 4.5,
        restaurant_name: "Mamalouka"
      }
    };

    // Check if the ID exists in the example data
    if (examples[id] && examples[id].restaurant_name === restaurant_name) {
      resolve(examples[id]); // Return the found rating
    } else {
      reject({ statusCode: 404, message: `Rating with ID '${id}' not found` }); // Return a 404 error
    }
  });
};


/**
 * Update a rating
 *
 * body Ratings Rating object that needs to be updated
 * restaurant_name String 
 * id String 
 * returns Ratings
 **/
exports.ratingsIdPUT = function(body, restaurant_name, id) {
  return new Promise(function(resolve, reject) {
    if (!id || !restaurant_name || !body) {
      reject({ statusCode: 400, message: 'ID, restaurant name, and body are required' });
      return;
    }

    // Simulate successful update
    var updatedRating = {
      user_id: body.user_id,
      rating: body.rating,
      restaurant_name: body.restaurant_name
    };

    resolve(updatedRating);
  });
};

/**
 * Create a new rating
 *
 * body Ratings Ratings object that needs to be added
 * restaurant_name String 
 * returns Ratings
 **/
// exports.ratingsPOST = function(body, restaurant_name) {
//   return new Promise(function(resolve, reject) {
//     if (!restaurant_name || !body) {
//       reject({ statusCode: 400, message: 'Restaurant name and body are required' });
//       return;
//     }

//     // Simulate adding a new rating
//     var newRating = {
//       user_id: body.user_id,
//       rating: body.rating,
//       restaurant_name: body.restaurant_name
//     };

//     resolve(newRating);
//   });
// };


exports.ratingsPOST = function (body, restaurant_name) {
  return new Promise(function (resolve, reject) {
    if (!restaurant_name || !body) {
      reject({ statusCode: 400, message: 'Restaurant name and body are required' });
      return;
    }

    // Validate required fields
    const requiredFields = ['user_id', 'rating', 'restaurant_name'];
    for (const field of requiredFields) {
      if (!body[field]) {
        console.error(`Missing required field: ${field}`);
        return reject({
          statusCode: 400,
          message: `Missing required field: ${field}`,
        });
      }
    }

    // Validate rating range
    if (body.rating < 1 || body.rating > 5) {
      console.error('Invalid rating value');
      return reject({
        statusCode: 400,
        message: 'Rating must be between 1 and 5',
      });
    }

    // Simulate adding the new rating
    const newRating = {
      user_id: body.user_id,
      rating: body.rating,
      restaurant_name: body.restaurant_name,
    };

    console.log('Created Rating:', newRating);
    resolve(newRating); // Return the created rating
  });
};
