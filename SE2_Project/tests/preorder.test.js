const test = require('ava'); // Import the AVA framework for running tests
const got = require('./init.test.js'); // Import the custom got instance defined in "init.tests.js"

/**
 * Helper to validate preorder item structure
 */
const validatePreorderStructure = (t, item) => {
  t.truthy(item.price, "Missing 'price' field");
  t.truthy(item.name, "Missing 'name' field");
  t.truthy(item.id, "Missing 'id' field");
  t.truthy(item.restaurant_name, "Missing 'restaurant_name' field");
};

/**
 * Test: Ensure GET /preorder returns the correct structure
 */
test.serial('GET /preorder returns correct structure', async (t) => {
  const { body, statusCode } = await t.context.got('preorder');
  t.is(statusCode, 200); // Ensure response code is 200
  t.true(Array.isArray(body), 'Response body should be an array');
  body.forEach((item) => validatePreorderStructure(t, item)); // Validate structure for each item
});

/**
 * Test: Ensure GET /preorder returns correct response and status code
 */
test.serial('GET /preorder returns correct response and status code', async (t) => {
  const { body, statusCode } = await t.context.got('preorder');
  t.is(statusCode, 200); // Ensure response code is 200
  t.true(Array.isArray(body), 'Response body should be an array');
  t.is(body.length, 2, 'Expected two preorder items');
  body.forEach((item) => validatePreorderStructure(t, item)); // Validate structure
});

/**
 * Test: POST /preorder returns a successful response
 */
test.serial('POST /preorder successful', async (t) => {
  const requestBody = {
    price: 9,
    name: 'meat',
    id: '106',
    restaurant_name: 'Restaurant',
  };

  const response = await t.context.got.post('preorder', {
    json: requestBody,
    responseType: 'json',
  });

  t.is(response.statusCode, 200); // Ensure response code is 200
  t.deepEqual(response.body, requestBody); // Ensure response body matches the request
});

/**
 * Test: POST /preorder fails for duplicate preorder
 */
test.serial('POST /preorder fails for duplicate preorder', async (t) => {
  const duplicateRequestBody = {
    price: 7,
    name: 'salat',
    id: '105',
    restaurant_name: 'Mamalouka',
  };

  const error = await t.throwsAsync(() =>
    t.context.got.post('preorder', {
      json: duplicateRequestBody,
      responseType: 'json',
    })
  );

  t.is(error.response.statusCode, 400); // Ensure response code is 400
  t.is(
    error.response.body.message,
    `Duplicate preorder with ID ${duplicateRequestBody.id} and restaurant_name ${duplicateRequestBody.restaurant_name}`
  );
});

/**
 * Test: POST /preorder fails for missing required fields
 */
test('POST /preorder fails for missing required fields', async (t) => {
  const testCases = [
    {
      description: 'missing "price"',
      requestBody: { name: 'meat', id: '106', restaurant_name: 'Restaurant' },
      missingFields: ['price'],
    },
    // Other test cases truncated for brevity
  ];

  for (const { description, requestBody, missingFields } of testCases) {
    const error = await t.throwsAsync(() =>
      t.context.got.post('preorder', {
        json: requestBody,
        responseType: 'json',
      })
    );

    t.is(error.response.statusCode, 400, `Status code mismatch for: ${description}`);
    t.is(
      error.response.body.message,
      `Missing required field(s): ${missingFields.join(' ')}`,
      `Error message mismatch for: ${description}`
    );
  }
});

/**
 * Test: GET /preorder/:id successful
 */
test.serial('GET /preorder/:id successful', async (t) => {
  const requestBody = {
    price: 9,
    name: 'meat',
    id: '106',
    restaurant_name: 'Restaurant',
  };

  const response = await t.context.got.get(`preorder/106`, {
    searchParams: { restaurant_name: 'Restaurant' },
  });

  t.is(response.statusCode, 200); // Ensure response code is 200
  t.deepEqual(response.body, requestBody); // Ensure response body matches the expected result
});

/**
 * Test: PUT /preorder/:id updates preorder successfully
 */
test.serial('PUT /preorder/:id successful', async (t) => {
  const updatedBody = {
    price: 12,
    name: 'grilled chicken',
    id: '106',
    restaurant_name: 'Restaurant',
  };

  const response = await t.context.got.put(`preorder/106`, {
    json: updatedBody,
    searchParams: { restaurant_name: 'Restaurant' },
    responseType: 'json',
  });

  t.is(response.statusCode, 200); // Ensure response code is 200
  t.deepEqual(response.body, updatedBody); // Ensure response body matches the updated values
});

/**
 * Test: DELETE /preorder/:id removes preorder successfully
 */
test.serial('DELETE /preorder/:id successful', async (t) => {
  const response = await t.context.got.delete('preorder/106', {
    responseType: 'json',
  });

  t.is(response.statusCode, 204); // Ensure response code is 204
});

/**
 * Test: GET /preorder/:id fails with invalid ID
 */
test.serial('GET /preorder/:id fails with invalid ID', async (t) => {
  const error = await t.throwsAsync(() =>
    t.context.got.get('preorder/9999', { searchParams: { restaurant_name: 'Restaurant' } })
  );

  t.is(error.response.statusCode, 404); // Ensure response code is 404
  t.is(error.response.body.message, 'Preorder not found');
});
