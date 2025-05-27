const test = require('ava'); // Import the ava framework for running tests
const got = require('./init.test.js'); // Import the custom got instance defined in "init.test.js"

// // SUCCESS CASE: Validate the response time of the endpoint is within acceptable limits

// SUCCESS CASE: The request should return a 200 status code and a list of reviews
test('GET /reviews successful with restaurantName', async (t) => {
  try {
    // Simulate a GET request with a valid restaurantName
    const response = await t.context.got.get('reviews', {
      searchParams: { restaurantName: 'mamalouka' }, // Use the expected restaurant name
      responseType: 'json'
    });

    // console.log('Response Status:', response.statusCode);
    // console.log('Response Body:', response.body);

    // Assert response status is 200
    t.is(response.statusCode, 200);

    // Assert response body is an array
    t.true(Array.isArray(response.body), 'Response should be an array of reviews');

    // Validate the structure of each review in the response
    response.body.forEach((review) => {
      t.truthy(review.id, 'Each review should have an id');
      t.truthy(review.user_id, 'Each review should have a user_id');
      t.truthy(review.restaurant_id, 'Each review should have a restaurant_id');
      t.true(typeof review.rating === 'number', 'Each review should have a numeric rating');
      t.truthy(review.comment, 'Each review should have a comment');
    });
  } catch (err) {
    console.error('Error:', err.response?.body || err.message);
    t.fail('Request failed with error: ' + err.message);
  }
});

// SUCCESS CASE: The request should return an empty array if restaurantName doesn't match
test('GET /reviews returns empty array for non-existent restaurantName', async (t) => {
  try {
    const response = await t.context.got.get('reviews', {
      searchParams: { restaurantName: 'invalid-restaurant' },
      responseType: 'json'
    });

    // console.log('Response Status:', response.statusCode);
    // console.log('Response Body:', response.body);

    // Assert response status is 200
    t.is(response.statusCode, 200);

    // Assert response body is an empty array
    t.deepEqual(response.body, [], 'Response should be an empty array for an invalid restaurant name');
  } catch (err) {
    console.error('Error:', err.response?.body || err.message);
    t.fail('Request failed with error: ' + err.message);
  }
});

// FAILURE CASE: The request should fail if restaurantName is not provided (optional)
test('GET /reviews returns all reviews when restaurantName is not provided', async (t) => {
  try {
    const response = await t.context.got.get('reviews', {
      responseType: 'json'
    });

    // console.log('Response Status:', response.statusCode);
    // console.log('Response Body:', response.body);

    // Assert response status is 200
    t.is(response.statusCode, 200);

    // Assert response body is an array of reviews
    t.true(Array.isArray(response.body), 'Response should be an array of reviews');

    // Validate the structure of each review
    response.body.forEach((review) => {
      t.truthy(review.id, 'Each review should have an id');
      t.truthy(review.user_id, 'Each review should have a user_id');
      t.truthy(review.restaurant_id, 'Each review should have a restaurant_id');
      t.true(typeof review.rating === 'number', 'Each review should have a numeric rating');
      t.truthy(review.comment, 'Each review should have a comment');
    });
  } catch (err) {
    console.error('Error:', err.response?.body || err.message);
    t.fail('Request failed with error: ' + err.message);
  }
});
// SUCCESS CASE: Check if ratings are within the expected range (1-5)
test('GET /reviews checks if all ratings are within 1 to 5', async (t) => {
  try {
    const response = await t.context.got.get('reviews', {
      responseType: 'json',
    });

    t.is(response.statusCode, 200);
    response.body.forEach((review) => {
      t.true(review.rating >= 1 && review.rating <= 5, `Rating ${review.rating} should be between 1 and 5`);
    });
  } catch (err) {
    t.fail(err.message);
  }
});

// FAILURE CASE: Ensure response is an empty array if there are no reviews at all
test('GET /reviews returns empty array if no reviews exist', async (t) => {
  try {
    const response = await t.context.got.get('reviews', {
      searchParams: { restaurantName: 'non-existent-data' },
      responseType: 'json',
    });

    t.is(response.statusCode, 200);
    t.deepEqual(response.body, [], 'Response should be an empty array if there are no reviews');
  } catch (err) {
    t.fail(err.message);
  }
});

// SUCCESS CASE: Ensure the response for reviews includes specific fields
test('GET /reviews ensures reviews include specific fields', async (t) => {
  try {
    const response = await t.context.got.get('reviews', {
      responseType: 'json',
    });

    t.is(response.statusCode, 200);
    response.body.forEach((review) => {
      t.truthy(review.id, 'Each review should have an "id" field');
      t.truthy(review.user_id, 'Each review should have a "user_id" field');
      t.truthy(review.restaurant_id, 'Each review should have a "restaurant_id" field');
      t.true(typeof review.rating === 'number', 'Each review should have a numeric "rating" field');
      t.truthy(review.comment, 'Each review should have a "comment" field');
    });
  } catch (err) {
    t.fail(err.message);
  }
});

// FAILURE CASE: The request should fail if an invalid query parameter is passed
test('GET /reviews fails with an invalid query parameter', async (t) => {
  try {
    const error = await t.throwsAsync(() =>
      t.context.got.get('reviews', {
        searchParams: { invalidParam: 'invalidValue' },
        responseType: 'json',
      })
    );

    t.is(error.response.statusCode, 400); // Assuming the server rejects invalid parameters with a 400 error
  } catch (err) {
    t.fail(err.message);
  }
});

// // SUCCESS CASE: Validate the response time of the endpoint is within acceptable limits
// test('GET /reviews responds within acceptable time', async (t) => {
//   const start = Date.now();
//   const response = await t.context.got.get('reviews', {
//     responseType: 'json',
//   });
//   const duration = Date.now() - start;

//   t.is(response.statusCode, 200);
//   t.true(duration < 500, `Response time exceeded: ${duration}ms`); // Expect response time to be under 500ms
// });

// FAILURE CASE: Check if server handles missing parameters gracefully
test('GET /reviews responds correctly when all parameters are missing', async (t) => {
  const response = await t.context.got.get('reviews', {
    responseType: 'json',
  });

  t.is(response.statusCode, 200);
  t.true(Array.isArray(response.body));
});

// FAILURE CASE: Ensure server responds correctly to unsupported HTTP methods
test('POST /reviews is not allowed', async (t) => {
  const error = await t.throwsAsync(() =>
    t.context.got.post('reviews', {
      json: { invalidField: 'test' },
      responseType: 'json',
    })
  );

  t.is(error.response.statusCode, 405); // Expect 405 Method Not Allowed
});

// SUCCESS CASE: Ensure the server supports a high number of concurrent requests
test('GET /reviews supports multiple concurrent requests', async (t) => {
  const requests = Array.from({ length: 10 }).map(() =>
    t.context.got.get('reviews', {
      responseType: 'json',
    })
  );

  const responses = await Promise.all(requests);
  responses.forEach((response) => {
    t.is(response.statusCode, 200);
    t.true(Array.isArray(response.body));
  });
});
