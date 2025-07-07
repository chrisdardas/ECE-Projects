// Description: Test cases for the ratings API endpoints
const test = require('ava');  //import the ava framework used for running tests
const got = require('./init.test.js');   //import the custom got instance defined in "init.tests.js"

test('POST /ratings allows creating rating for any restaurant', async (t) => {
  const requestBody = {
    "user_id": "user32",
    "rating": 4.5,
    "restaurant_name": "TestRestaurant"
  };

  const queryBody = requestBody.restaurant_name;
  // console.log("THIS THE QUERY BODY : ", queryBody);
  
  try {
    const response = await t.context.got.post(`ratings?restaurant_name=${queryBody}`, {
      json: requestBody,
      responseType: 'json'
    });

    t.is(response.statusCode, 200); // Check if the status code is 200
    t.deepEqual(response.body, requestBody); // Assert the response body matches the request data
  } catch (err) {
    console.error('Full Error Object :', err);
    console.error('ERROR RESPONSE HERE :', err.response ? err.response.body : 'No response body');
    t.fail(`Request failed with error: ${err.message}`);
  }
});

// Failure test case: POST /ratings fails when required fields are missing
test('POST /ratings fails when required fields are missing', async (t) => {
  const invalidRequestBody = {
    "user_id": "user32",
    // Missing "rating" and "restaurant_name"
  };

  const error = await t.throwsAsync(() =>
    t.context.got.post('ratings', {
      json: invalidRequestBody,
      responseType: 'json'
    })
  );

  t.is(error.response.statusCode, 400); // Assert the status code is 400
  // console.log("This is the response body: ", error.response.body.message)
  t.is(
    error.response.body.message,
    //'Missing required field: rating',
    //'Error message should indicate the missing field',
    "request.query should have required property 'restaurant_name'"
  );
});


// Test case for GET /ratings with a valid restaurant name
test('GET /ratings successful', async (t) => {
  const restaurantName = "mamalouka";

  try {
    const response = await t.context.got.get(`ratings?restaurant_name=${restaurantName}`, {
      responseType: 'json'
    });

    t.is(response.statusCode, 200); // Check if the status code is 200
    t.true(Array.isArray(response.body)); // Assert the response body is an array
    t.is(response.body[0].restaurant_name, restaurantName); // Check if the restaurant name matches
  } catch (err) {
    console.error('Error: ', err.response.body);
    t.fail('Request failed with error: ' + err.message);
  }
});

// Test case for GET /ratings with an invalid restaurant name
test('GET /ratings fails with non-existent restaurant_name', async (t) => {
  const restaurantName = "Test";

  try {
    await t.context.got.get(`ratings?restaurant_name=${restaurantName}`, {
      responseType: 'json'
    });

    t.fail('Request should have failed but did not');
  } catch (err) {
    t.is(err.response.statusCode, 404); // Check if the status code is 404
    t.is(err.response.body.error, 'Rating not found'); // Check the error message

  }
});

// Test case for GET /ratings with an empty restaurant name
test('GET /ratings fails with empty restaurant_name', async (t) => {
  const restaurantName = " ";

  try {
    await t.context.got.get(`ratings?restaurant_name=${restaurantName}`, {
      responseType: 'json'
    });

    t.fail('Request should have failed but did not');
  } catch (err) {
    t.is(err.response.statusCode, 400); // Check if the status code is 400
    // console.log("This is the response: ", err.response.body.errors[0].message);
    t.is(err.response.body.errors[0].message, "Empty value found for query parameter 'restaurant_name'"); // Check the error message
    // t.is(err.response.body.message, "Empty value found for query parameter \'restaurant_name\'");
  }
});

// Test case for GET /ratings/{id} to retrieve a specific rating
test('GET /ratings/{id} successful', async (t) => {
  const ratingId = "user32"; // Valid rating ID
  const restaurantName = "Mamalouka"; // Valid restaurant name

  try {
    const response = await t.context.got.get(`ratings/${ratingId}`, {
      searchParams: { restaurant_name: restaurantName },
      responseType: 'json',
    });


    t.is(response.statusCode, 200); // Expect status 200
    t.deepEqual(response.body, {
      "user_id": "user32",
      "rating": 4.5,
      "restaurant_name": "Mamalouka",
    }); // Expect exact body match
  } catch (err) {
    console.error('Error: ', err.response?.body);
    t.fail(`Request failed with error: ${err.message}`);
  }
});



// Test case for PUT /ratings/{id} to update a rating
test('PUT /ratings/{id} successful', async (t) => {
  const ratingId = "user32"; // Valid rating ID
  const restaurantName = "mamalouka";
  const requestBody = {
    "user_id": "user32",
    "rating": 5.0,
    "restaurant_name": "mamalouka"
  };

  try {
    const response = await t.context.got.put(`ratings/${ratingId}?restaurant_name=${restaurantName}`, {
      json: requestBody,
      responseType: 'json'
    });

    t.is(response.statusCode, 200); // Check if the status code is 200
    t.deepEqual(response.body, requestBody);  // Assert the response body matches the updated data
  } catch (err) {
    console.error('Error: ', err.response.body);
    t.fail('Request failed with error: ', + err.message);
  }
});

// Test case for DELETE /ratings/{id} to delete a rating
test('DELETE /ratings/{id} successful', async (t) => {
  const ratingId = "user32"; // Valid rating ID

  try {
    const response = await t.context.got.delete(`ratings/${ratingId}`, {
      responseType: 'json'
    });

    // console.log('Response Status:', response.statusCode);
    // console.log('Response Body:', response.body);

    t.is(response.statusCode, 204); // Check if the status code is 200
  } catch (err) {
    console.error('Error: ', err.response.body);
    t.fail('Request failed with error: ', + err.message);
  }
});

test('DELETE /ratings/{id} unsuccessful', async (t) => {
  const ratingId = "user32fdasfsdf"; // Valid rating ID

  try {
    const error = await t.throwsAsync(() => t.context.got.delete(`ratings/${ratingId}`, {
      responseType: 'json'
    }));

    // console.log('Response Status:', response.statusCode);
    // console.log('Response Body:', response.body);

    t.is(error.response.statusCode, 404); // Check if the status code is 404
    t.is(error.response.body.error, "Rating not found");
  } catch (err) {
    console.error('Error (CHILL): ', err.response.body);
    t.fail('Request failed with error: ', + err.message);
  }
});

// Test case for POST /ratings fails when required fields are missing
test('POST /ratings fails when required fields are missing (restaurant Name)', async (t) => {
  const requestBody = {
    "user_id": "user32",
    "rating": 4.5
    // Missing restaurant_name
  };

  const restaurantName = "Test"; 
  // console.log("WHAAAAAAAAATTTTTTTTTTTTTTT");

  try{
    // console.log("PRINT THIS");
    const error = await t.throwsAsync(() => t.context.got.post(`ratings?restaurant_name=${restaurantName}`, {
      json: requestBody,
      responseType: 'json'
    }));
    // console.log("THIS IS THE RESPONSE (CHILLLLLLLLLLLL) : ", error.body, error.statusCode);
    console.log("ERROR MESSAGE : ", error.message);
    t.is(error.message, 'Response code 400 (Bad Request)');
  } catch(err) {
    console.error('Error: ', err.response.body);
    t.fail('Request failed with error: ', + err.message);
  }
  
});



// Test case for GET /ratings/{id} fails when rating not found
test('GET /ratings/{id} fails when rating not found', async (t) => {
  const ratingId = "nonexistentId"; // Invalid rating ID
  const restaurantName = "mamalouka";

  const error = await t.throwsAsync(() => t.context.got(`ratings/${ratingId}?restaurant_name=${restaurantName}`));

  t.is(error.message, 'Response code 404 (Not Found)');
});

// Negative Test Case: POST /ratings fails when required fields are missing
test('POST /ratings fails with 400 when required fields are missing', async (t) => {
  const requestBody = {
    user_id: 'user32'
    // Missing the "rating" field
  };

  const error = await t.throwsAsync(() =>
    t.context.got.post('ratings?restaurant_name=Mamalouka', {
      json: requestBody,
      responseType: 'json'
    })
  );

  t.is(error.response.statusCode, 400); // Assert the status code is 400 (Bad Request)
});

// Negative Test Case: GET /ratings/{id} fails when rating ID does not exist
test('GET /ratings/{id} fails with 404 for a nonexistent ID', async (t) => {
  const ratingId = 'nonexistentId';
  const restaurantName = 'mamalouka';

  const error = await t.throwsAsync(() =>
    t.context.got.get(`ratings/${ratingId}?restaurant_name=${restaurantName}`, {
      responseType: 'json'
    })
  );

  t.is(error.response.statusCode, 404); // Assert the status code is 404 (Not Found)
});

test('GET /ratings validates the structure of the response', async (t) => {
  const restaurantName = "mamalouka";

  const response = await t.context.got.get(`ratings?restaurant_name=${restaurantName}`, {
    responseType: 'json'
  });

  t.is(response.statusCode, 200); // Expect 200 OK
  t.true(Array.isArray(response.body)); // Check response is an array

  response.body.forEach((rating) => {
    t.truthy(rating.user_id); // Check user_id exists
    t.truthy(rating.rating); // Check rating exists
    t.truthy(rating.restaurant_name); // Check restaurant_name exists
    t.is(rating.restaurant_name, restaurantName); // Check restaurant_name matches
  });
});