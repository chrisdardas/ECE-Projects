const test = require('ava');  // Import the AVA framework for running tests
const got = require('./init.test.js');   // Import the custom got instance defined in "init.tests.js"

/* =========================
   Successful Payment Tests
   ========================= */

/**
 * Test that POST /payBookingFee succeeds with valid input.
 */
test('POST /payBookingFee successful', async (t) => {
    const requestBody = {
        "cardHolderName": "John Doe",
        "cardNumber": "1234567891234568",
        "CVC": 123,
        "expirationDate": "07/2026"
    };
    try {
        const response = await t.context.got.post('payBookingFee', {
            json: requestBody,
            responseType: 'json'
        });

        // Assert that the response status code is 200
        t.is(response.statusCode, 200);
        // Assert that the response body matches the expected result
        t.deepEqual(response.body, { success: true });
    } catch (err) {
        console.error('Error:', err.response.body);
        t.fail('Request failed with error: ' + err.message);
    }
});

/* =========================
   Failure Case Tests
   ========================= */

/**
 * Test that POST /payBookingFee fails when "CVC" is missing.
 */
test('POST /payBookingFee fails when "CVC" is missing', async (t) => {
    const requestBody = {
        "cardHolderName": "John Doe",
        "cardNumber": "1234567891234568",
        "expirationDate": "07/2026"
        // Missing "CVC" 
    };

    const error = await t.throwsAsync(() => t.context.got.post('payBookingFee', {
        json: requestBody,
        responseType: 'json'
    }));

    t.is(error.message, 'Response code 400 (Bad Request)');
});

/**
 * Test that POST /payBookingFee fails when "expirationDate" is missing.
 */
test.serial('POST /payBookingFee fails when "expirationDate" is missing', async (t) => {
    const requestBody = {
        "cardHolderName": "John Doe",
        "cardNumber": "1234567891234568",
        "CVC": 123
        // Missing "expirationDate" 
    };

    const error = await t.throwsAsync(() => t.context.got.post('payBookingFee', {
        json: requestBody,
        responseType: 'json'
    }));

    t.is(error.message, 'Response code 400 (Bad Request)');
});

/**
 * Test that POST /payBookingFee fails when "cardHolderName" is missing.
 */
test.serial('POST /payBookingFee fails when "cardHolderName" is missing', async (t) => {
    const requestBody = {
        // "cardHolderName": "John Doe",
        "cardNumber": "1234567891234568",
        "CVC": 123,
        "expirationDate": "07/2026"
    };

    const error = await t.throwsAsync(() => t.context.got.post('payBookingFee', {
        json: requestBody,
        responseType: 'json'
    }));

    t.is(error.message, 'Response code 400 (Bad Request)');
});

/**
 * Test that POST /payBookingFee fails when "cardNumber" is missing.
 */
test.serial('POST /payBookingFee fails when "cardNumber" is missing', async (t) => {
    const requestBody = {
        "cardHolderName": "John Doe",
        // "cardNumber": "12345678912345680000",
        "CVC": 123,
        "expirationDate": "07/2026"
    };

    const error = await t.throwsAsync(() => t.context.got.post('payBookingFee', {
        json: requestBody,
        responseType: 'json'
    }));

    t.is(error.message, 'Response code 400 (Bad Request)');
});

/**
 * Test that POST /payBookingFee fails when all fields are missing.
 */
test.serial('POST /payBookingFee fails when everything is missing', async (t) => {
    const requestBody = {
        "cardHolderName": null,
        "cardNumber": null,
        "CVC": null,
        "expirationDate": null
    };

    const error = await t.throwsAsync(() => t.context.got.post('payBookingFee', {
        json: requestBody,
        responseType: 'json'
    }));

    t.is(error.message, 'Response code 400 (Bad Request)');
});

/* =========================
   Method Not Allowed Tests
   ========================= */

/**
 * Test that PUT /payBookingFee returns 405 Method Not Allowed.
 */
test('PUT /payBookingFee returns 405 method not allowed', async (t) => {
    const requestBody = { 
        "cardHolderName": "John Doe",
        "cardNumber": "1234567891234568",
        "CVC": 123,
        "expirationDate": "07/2026"
    };

    try {
        const error = await t.throwsAsync(() => t.context.got.put('payBookingFee', {
            json: requestBody,
            responseType: 'json'
        }));
        t.is(error.response.statusCode, 405);
    } catch (err) {
        console.log('Error:', err);
        throw err;
    }
});

/**
 * Test that GET /payBookingFee returns 405 Method Not Allowed.
 */
test('GET /payBookingFee returns 405 method not allowed', async (t) => {
    try {
        const error = await t.throwsAsync(() => t.context.got('payBookingFee'));
        t.is(error.response.statusCode, 405);
    } catch (err) {
        console.log('Error:', err);
        throw err;
    }
});

/**
 * Test that DELETE /payBookingFee returns 405 Method Not Allowed.
 */
test('DELETE /payBookingFee returns 405 method not allowed', async (t) => {
    const requestBody = {
        "cardHolderName": "John Doe",
        "cardNumber": "1234567891234568",
        "CVC": 123,
        "expirationDate": "07/2026"
    };
    try {
        const error = await t.throwsAsync(() => t.context.got.delete('payBookingFee'));
        t.is(error.response.statusCode, 405);
    } catch (err) {
        console.log('Error:', err);
        throw err;
    }
});

/* =========================
   Input Validation Tests
   ========================= */

/**
 * Test that POST /payBookingFee fails with invalid CVC input.
 */
test.serial('POST /payBookingFee fails with invalid CVC', async (t) => {
    const requestBody = {
        "cardHolderName": "John Doe",
        "cardNumber": "1234567891234568",
        "CVC": "ABC",  // Invalid CVC
        "expirationDate": "07/2026"
    };

    const error = await t.throwsAsync(() => t.context.got.post('payBookingFee', {
        json: requestBody,
        responseType: 'json'
    }));

    t.is(error.message, 'Response code 400 (Bad Request)');
});

/**
 * Test that POST /payBookingFee fails with an overly long card holder name.
 */
test.serial('POST /payBookingFee fails with overly long card holder name', async (t) => {
    const requestBody = {
        "cardHolderName": "A".repeat(300),  // Excessively long name
        "cardNumber": "1234567891234568",
        "CVC": 123,
        "expirationDate": "07/2026"
    };

    const error = await t.throwsAsync(() => t.context.got.post('payBookingFee', {
        json: requestBody,
        responseType: 'json'
    }));

    t.is(error.message, 'Response code 400 (Bad Request)');
});

/**
 * Test that POST /payBookingFee fails with invalid name input.
 */
test.serial('POST /payBookingFee fails with wrong name input', async (t) => {
    const requestBody = {
        "cardHolderName": "John$%Doe",  // Invalid characters in name
        "cardNumber": "1234567891234568",
        "CVC": 123,
        "expirationDate": "07/2026"
    };

    const error = await t.throwsAsync(() => t.context.got.post('payBookingFee', {
        json: requestBody,
        responseType: 'json'
    }));

    t.is(error.message, 'Response code 400 (Bad Request)');
});

/**
 * Test that POST /payBookingFee fails with an invalid card number.
 */
test('POST /payBookingFee fails with invalid card number', async(t) => {
    const requestBody = {
        "cardHolderName": "John Doe",
        "cardNumber": "123456789123456kajshd",  // Invalid card number
        "CVC" : 123,
        "expirationDate": "07/2026"
    };

    try {
        const error = await t.throwsAsync(() => t.context.got.post('payBookingFee', {
            json: requestBody,
            responseType: 'json'
        }));
        t.is(error.message, 'Response code 400 (Bad Request)');
    } catch(err){
        console.log('Error:', err);
        throw err;
    }
});

/**
 * Test that POST /payBookingFee fails with an invalid CVC input.
 */
test('POST /payBookingFee fails with invalid CVC input', async(t) => {
    const requestBody = {
        "cardHolderName": "John Doe",
        "cardNumber": "1234567891234568",
        "CVC":123124,  // CVC out of valid range
        "expirationDate":"07/2026"
    };

    try{
        const error = await t.throwsAsync(() => t.context.got.post('payBookingFee', {
            json: requestBody,
            responseType: 'json'
        }));
        t.is(error.message, 'Response code 400 (Bad Request)');
    } catch(err) {
        console.log('Error:', err);
        throw err;
    }
});

/**
 * Test that POST /payBookingFee fails with an invalid expiration date input.
 */
test('POST /payBookingFee fails with invalid Date input', async(t) => {
    const requestBody = {
        "cardHolderName":"John Doe",
        "cardNumber": "1234567891234568",
        "CVC":123,
        "expirationDate":"19/09"  // Invalid date format
    };

    try{
        const error = await t.throwsAsync(() => t.context.got.post("payBookingFee", {
            json: requestBody,
            responseType: 'json'
        }));
        t.is(error.message, 'Response code 400 (Bad Request)');
    } catch(err) {
        console.log('Error:', err);
        throw err;
    }
});