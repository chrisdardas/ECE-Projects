'use strict';


/**
 * Retrieve a list of restaurants
 *
 * returns List
 **/
exports.searchGET = function simulateError(req) {
  return new Promise(function(resolve, reject) {
    const simulateError = req.query.mockError ==='true' // to enable mock errors
    // console.log("Simulate Error: ", simulateError);
    
    if(simulateError){
      reject({error: 'Mock error'});
    } else{
        var examples = {};
        examples['application/json'] = [ 
        {
          "address" : "Leoforou Stratou 34",
          "restaurantName" : "Mamalouka"
        }, 
        {
          "address" : "Tsimiski 20",
          "restaurantName" : "Estrella"
        }
      ];
        resolve(examples['application/json']);
    }

    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}

