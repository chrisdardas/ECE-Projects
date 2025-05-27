'use strict';


/**
 * Cancel a reservation
 * Cancel an existing reservation
 *
 * id String 
 * no response value expected for this operation
 **/
// exports.cancelReservation = function(id) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }
exports.cancelReservation = function(id) {
  return new Promise(function(resolve, reject) {
    if (!id) {
      reject({ statusCode: 404, message: 'ID is required' });
      return;
    }

    // Mock database of reservations
    const database = {
      '101': { id: '101', guest: 'John Doe', date: '2024-12-01' },
      '105': { id: '105', guest: 'Jane Smith', date: '2024-12-02' },
    };

    if (database[id]) {
      // Simulate deletion from the database
      delete database[id];
      resolve(true); // Successfully deleted
    } else {
      resolve(false); // Reservation not found
    }
  });
};


/**
 * Retrieve a specific reservation
 * Retrieve details of a specific reservation
 *
 * id String 
 * returns Reservation
 **/
exports.getReservation = function (id, restaurantName) {
  return new Promise(function (resolve, reject) {
      restaurantName = 'Mamalouka'; // Dynamic restaurant name
      const examples = {
          '105': {
              date: "2000-01-23T04:56:07.000+00:00",
              allergies: "Mushrooms",
              restaurant_name:`${restaurantName}`, // Return the dynamic restaurant name
              id: "105",
              time: "2000-01-23T04:56:07.000+00:00"
          }
      };

      const reservation = examples[id];
      if (!reservation) {
          return reject({ statusCode: 404, message: 'Reservation not found' });
      }

      resolve(reservation);
  });
};



/**
 * Retrieve a list of reservations
 * Retrieve a list of all reservations
 *
 * returns List
 **/
exports.listReservations = function (restaurantName) {
  return new Promise(function (resolve, reject) {
    const reservations = [
      {
        "date": "2000-01-23T04:56:07.000+00:00",
        "allergies": "Mushrooms",
        "restaurantName": "Mamalouka",
        "id": "105",
        "time": "2000-01-23T04:56:07.000+00:00"
      }
    ];

    // Αν δεν υπάρχει restaurantName, επιστρέφουμε όλες τις κρατήσεις
    if (!restaurantName) {
      resolve(reservations);
    } else {
      const filtered = reservations.filter(r => r.restaurantName === restaurantName);
      if (filtered.length === 0) {
        reject(new Error('No reservations found for this restaurant'));
      } else {
        resolve(filtered);
      }
    }
  });
};



/**
 * Make a reservation
 * Make a new reservation
 *
 * body Reservation 
 * restaurantName String 
 * returns Reservation
 **/
exports.makeReservation = function (body, restaurantName) {
  return new Promise(function (resolve, reject) {
      if (!restaurantName || !body) {
          return reject({ statusCode: 400, message: 'Restaurant name and reservation body are required' });
      }

      const newReservation = {
          id: Math.random().toString(36).substring(2, 9), // Generate random ID
          ...body,
          restaurant_name: restaurantName, // Include dynamic restaurant name
      };

      resolve(newReservation);
  });
};





/**
 * Update a reservation
 * Update an existing reservation
 *
 * body Reservation Reservation object that needs to be updated
 * id String 
 * returns Reservation
 **/
exports.updateReservation = function() {
  return new Promise(function(resolve, _) {
    var examples = {};
    examples['application/json'] = {
  "date" : "2000-01-23T04:56:07.000+00:00",
  "allergies" : "Mushrooms",
  "restaurantName" : "Mamalouka",
  "id" : "105",
  "time" : "2000-01-23T04:56:07.000+00:00"
};
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}

