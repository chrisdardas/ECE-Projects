const test = require('ava'); //import the ava framework used for running tests
const got = require('./init.test'); //import the custom got instance defined in "init.tests.js"

// Testing if the response time is lower than 500ms
test.serial('GET /search acceptable time response', async (t) => {
    const start = Date.now();
    await t.context.got('search');
    const duration = Date.now() - start;
    t.true(duration < 500);
});

test('Get /search returns correct structure', async (t) => {
    try{
        const {body, statusCode} = await t.context.got('search');
        t.is(statusCode, 200); // Checking if we received the correct status code
        body.forEach((item) => { 
            t.truthy(item.address); // Ensures each result has an address field
            t.truthy(item.restaurantName); // Ensures each result has a restaurantName field
        });
    } catch(err){
        console.log('Error: ', err);
        throw err;
    }
});


test('Get /search returns correct response and status code', async(t) => {
	try {
        const {body, statusCode} = await t.context.got("search"); // Send GET request to /search endpoint (from the search controller)
        t.deepEqual(body, [
            {
                address: 'Leoforou Stratou 34',
                restaurantName: 'Mamalouka',
            },
            {
                address: 'Tsimiski 20',
                restaurantName: 'Estrella',
            }
        ]);
        // console.log('Test: Received response:', body);
        t.is(statusCode, 200); 
    } catch(err){
        console.log('Error : ', err);
        throw err;
    }
});


// testing POST method
test('POST /search returns 405 method not allowed', async(t) => {
    try{
        const error = await t.throwsAsync(() => t.context.got.post("search"));
        t.is(error.response.statusCode, 405);
    } catch(err){
        console.log('Error : ', err);
        throw err;
    }
});

// testing PUT method
test('PUT /search returns 405 method not allowed', async(t) => {
    try{
        const error = await t.throwsAsync(() => t.context.got.put("search"));
        t.is(error.response.statusCode, 405);
    } catch(err){
        console.log('Error: ', err);
        throw err;
    }
});

// testing DELETE method
test('DELETE /search returns 405 method not allowed', async(t) => {
    try{
        const error = await t.throwsAsync(() => t.context.got.delete("search"));
        t.is(error.response.statusCode, 405);
    } catch(err){
        console.log('Error: ', err);
        throw err;
    }
});

// Check for invalid endpoint
test('GET /search returns 404 for non-existent endpoint', async (t) => {
    const error = await t.throwsAsync(() => t.context.got('nonexistentendpoint'));

    t.is(error.response.statusCode, 404);  
});

test.serial('GET /search with mockError=true simulates a server error', async (t) => {
    const error = await t.throwsAsync(() =>
      t.context.got('search', { searchParams: { mockError: 'true' } }) // Pass query parameter
    );
    
    // console.log('Error: ', error.response.statusCode);
    t.is(error.response.statusCode, 500); // Expect 500 Internal Server Error
    t.deepEqual(error.response.body, { error: 'Mock Error' }); // Check mock error response
  });

// Stress testing the search endpoint
test('GET /search handles concurrent requests', async (t) => {
    const requests = [...Array(10)].map(() => t.context.got('search'));
    const responses = await Promise.all(requests);
    responses.forEach((response) => {
        t.is(response.statusCode, 200);
        t.true(Array.isArray(response.body));
    });
});




