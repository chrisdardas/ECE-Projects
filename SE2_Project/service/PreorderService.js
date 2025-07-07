'use strict';

// In-memory storage for preorders (this will reset when the server restarts)
// Sample data to initialize preOrders
let preOrders = [
  { price: 7, name: "salat", id: "105", restaurant_name: "Mamalouka" },
  { price: 8, name: "pasta", id: "110", restaurant_name: "Pastabar" }
];

// Check for duplicate preorders
exports.checkDuplicate = function (id, restaurant_name) {
  return new Promise((resolve) => {
    const isDuplicate = preOrders.some(
      (order) => order.id === id && order.restaurant_name === restaurant_name
    );
    resolve(isDuplicate); // Return true if duplicate exists
  });
};

/**
 * Retrieve a list of menu items
 *
 * returns List
 **/
exports.preOrderGET = function() {
  return new Promise(function(resolve) {


    // Check if there are any preorders
    if (preOrders.length > 0) {
      // Resolve with the current list of preorders
      resolve(preOrders);
    } else {
      // Resolve with an empty array if no preorders exist
      resolve([]);
    }
  });
};
/**
 * Delete a menu item
 *
 * id String 
 * no response value expected for this operation
 **/
exports.preOrderIdDELETE = function (id) {
  return new Promise(function (resolve, reject) {
    const index = preOrders.findIndex(order => order.id === id);

    if (index === -1) {
      reject({
        status: 404,
        message: `Preorder with ID ${id} not found`
      });
      return;
    }

    // Remove the preorder
    preOrders.splice(index, 1);

    resolve(); // Indicate successful deletion
  });
}
/**
 * Retrieve a specific menu item
 *
 * id String 
 * restaurant_name String 
 * returns PreOrder
 **/
exports.preOrderIdGET = function (id, restaurant_name) {
  return new Promise(function (resolve, reject) {
      // Find the preorder that matches both the ID and restaurant_name
      const preorder = preOrders.find(
          (order) => order.id === id && order.restaurant_name === restaurant_name
      );

      if (preorder) {
          resolve(preorder); // Resolve with the found preorder
      } else {
          reject(new Error('Preorder not found')); // Reject with an appropriate error message
      }
  });
};



/**
 * Update a menu item
 *
 * body PreOrder Menu item object that needs to be updated
 * restaurant_name String 
 * id String 
 * returns PreOrder
 **/

exports.preOrderIdPUT = function (body, restaurant_name, id) {
    return new Promise(function (resolve, reject) {
        // Find the preorder by id and restaurant_name
        const index = preOrders.findIndex(order => order.id === id && order.restaurant_name === restaurant_name);

        if (index === -1) {
            reject({
                status: 404,
                message: `Preorder with ID ${id} and restaurant_name ${restaurant_name} not found`
            });
            return;
        }

        // Update the preorder
        preOrders[index] = { ...preOrders[index], ...body };

        // Return the updated preorder
        resolve(preOrders[index]);
    });
};

/**
 * Create a new menu item
 *
 * body PreOrder Menu item object that needs to be added
 * returns PreOrder
 **/
exports.preOrderPOST = function (body) {
  return new Promise((resolve) => {
    // Create and store the preorder
    const newPreOrder = {
      price: body.price,
      name: body.name,
      id: body.id,
      restaurant_name: body.restaurant_name,
    };

    preOrders.push(newPreOrder);
    resolve(newPreOrder); // Return the created preorder
  });
};