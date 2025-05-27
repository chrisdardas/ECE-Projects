const test = require('ava'); // Εισάγουμε το AVA για την εκτέλεση των tests
const got  = require('./init.test'); // Εισάγουμε το got από το init.test.js

// GET /reservations - Ελέγχει αν επιστρέφεται λίστα κρατήσεων
test.serial('GET /reservations returns a list of reservations', async (t) => {
    // const client = got.extend({
    //     prefixUrl: 'http://localhost:3000', // Ensure this is correct
    //     responseType: 'json',
    //     throwHttpErrors: false // Prevents got from rejecting the promise automatically
    // });

    try {
        const response = await t.context.got('reservations'); // Perform GET request to /reservations

        // console.log('Response status code:', statusCode);
        // console.log('Response body:', body);
        // console.log("TANIIIIAAAAAA : ", response);
        t.is(response.statusCode, 200);
        t.true(Array.isArray(response.body), 'The body should be an array');

        response.body.forEach((reservation) => {
            t.truthy(reservation.restaurantName, 'The reservation should have restaurantName');
            t.truthy(reservation.date, 'The reservation should have date');
        });
    } catch (err) {
        console.error('Error in GET /reservations:', err);
        t.fail('The test failed due to an error');
    }
});


// // GET /reservations - Returns error for invalid restaurant name
// test.serial('GET /reservations returns error for invalid restaurant name', async (t) => {
//   const client = got(t); // Retrieve the correct instance of got
//   try {
//     const { body, statusCode } = await client('reservations', {
//       searchParams: { restaurantName: 'InvalidRestaurant' }, // Pass invalid restaurant name
//     });

//     t.is(statusCode, 404); // Expect a 404 status code
//     t.is(body.message, 'Rating not found'); // Expect the error message
//   } catch (err) {
//     console.error('Error in GET /reservations:', err.response ? err.response.body : err);
//     throw err;
//   }
// });


test('POST /reservations creates a new reservation with any restaurant name', async (t) => {
    const client = t.context.got;
    const newReservation = {
        date: '2024-12-01T20:00:00Z',
        allergies: 'None',
        time: '2024-12-01T20:00:00Z',
    };

    const restaurantName = 'AnyRestaurant'; // Dynamic restaurant name

    const response = await client.post('reservations', {
        searchParams: { RestaurantName: restaurantName },
        json: newReservation,
        responseType: 'json',
    });

    const { body, statusCode } = response;

    t.is(statusCode, 201, 'Expected status 201 for successful reservation');
    t.truthy(body.id, 'ID should be returned');
    t.deepEqual(body.restaurant_name, restaurantName, 'Restaurant name does not match');
});

// test('GET /reservations/{id} returns reservation with any restaurant name', async (t) => {
//     const client = t.context.got;
//     const reservationId = '105';
//     const restaurantName = 'AnyRestaurant';

//     const response = await client(`reservations/${reservationId}`, {
//         searchParams: { RestaurantName: restaurantName },
//     });

//     const { body, statusCode } = response;

//     t.is(statusCode, 200, 'Expected status 200');
//     t.deepEqual(body.restaurant_name, restaurantName, 'Returned restaurant name does not match');
// });

test('GET /reservations/{id} returns reservation by ID', async (t) => {
    const client = t.context.got;
    const reservationId = '105'; // Test ID for the reservation
  
    try {
      const response = await client(`reservations/${reservationId}`); // No query params needed
      const { body, statusCode } = response;
  
      t.is(statusCode, 200, 'Expected status 200');
      t.is(body.id, reservationId, 'Returned reservation ID does not match');
      console.log("!!!!!!!!!!!!!!!" ,body);
      t.truthy(body.restaurant_name, 'Reservation should have a restaurant name');
    } catch (err) {
      console.error('Error in GET /reservations/{id}:', err.response?.body || err.message);
      t.fail(`Test failed due to error: ${err.response?.body?.message || err.message}`);
    }
  });
  



// PUT /reservations/{id} - Ενημερώνει κράτηση
test('PUT /reservations/{id} updates a reservation', async (t) => {
    const client = t.context.got;
    const reservationId = '105'; // Δοκιμαστικό ID
    const updatedReservation = {
        date: '2000-01-23T04:56:07.000Z',
        allergies: 'Peanuts',
        restaurantName: 'Mamalouka',  // Η τιμή που είχε και η παλιά κράτηση
        time: '2024-12-01T20:00:00Z',
    };

    try {
        const { body, statusCode } = await client.put(`reservations/${reservationId}`, {
            json: updatedReservation,
            responseType: 'json',
        });

        // console.log('PUT /reservations/{id} Response:', body);

        t.is(statusCode, 200, `Expected status 200 but got ${statusCode}`);
        t.deepEqual(new Date(body.date).toISOString(), updatedReservation.date, 'Date does not match');
        t.deepEqual(body.restaurantName, updatedReservation.restaurantName, 'Restaurant name does not match');
    } catch (err) {
        console.error('Error in PUT /reservations/{id}:', err.response?.body || err);
        t.fail('PUT request failed');
    }
});


// DELETE /reservations/{id} - Διαγράφει κράτηση
test('DELETE /reservations/{id} cancels a reservation', async (t) => {
    //const client = got(t);
    const reservationId = '105'; // Δοκιμαστικό ID, βεβαιώσου ότι υπάρχει στο API
    try {
        const response = await t.context.got.delete(`reservations/${reservationId}`);
        // console.log(`DELETE /reservations/{id} StatusCode: ${statusCode}`);

        t.is(response.statusCode, 204); // Καμία περιγραφή, μόνο επιτυχία
    } catch (err) {
        console.error('Error in DELETE /reservations/{id}:', err.response ? err.response.body : err);
        throw err;
    }
});


// POST /reservations - Αποτυχία δημιουργίας κράτησης λόγω μη έγκυρων δεδομένων
test('POST /reservations fails with invalid data', async (t) => {
    const client = t.context.got;
    const invalidReservation = {
        date: 'invalid-date',
        allergies: 123,
    };

    const restaurantName = 'Mamalouka';

    try {
        await client.post('reservations', {
            searchParams: { RestaurantName: restaurantName },
            json: invalidReservation,
            responseType: 'json',
        });
        t.fail('POST should have failed with invalid data');
    } catch (err) {
        t.is(err.response?.statusCode, 400, 'Expected status 400 for invalid data');
        // Απλά έλεγχος για την ύπαρξη οποιουδήποτε σώματος στην απόκριση
        t.truthy(err.response?.body, 'Expected some response body');
    }
});


// POST /reservations - Αποτυχία δημιουργίας κράτησης χωρίς το όνομα του εστιατορίου
test('POST /reservations fails without RestaurantName', async (t) => {
    const client = t.context.got;
    const newReservation = {
        date: '2024-12-01T20:00:00Z',
        allergies: 'None',
        time: '2024-12-01T20:00:00Z',
    };

    try {
        await client.post('reservations', {
            json: newReservation,
            responseType: 'json',
        });
        t.fail('POST should have failed without RestaurantName');
    } catch (err) {
        t.is(err.response?.statusCode, 400, 'Expected status 400 for missing RestaurantName');
        t.truthy(err.response?.body, 'Expected response body for missing RestaurantName');
    }
});


test('PUT /reservations/{id} fails with invalid fields', async (t) => {
    const client = t.context.got;
    const reservationId = '105';
    const invalidData = {
        date: 'invalid-date',
        time: 'invalid-time',
        allergies: 123, // Μη έγκυρη τιμή
    };

    try {
        await client.put(`reservations/${reservationId}`, {
            json: invalidData,
            responseType: 'json',
        });
        t.fail('Request should have failed with invalid fields');
    } catch (err) {
        t.is(err.response?.statusCode, 400, 'Expected status 400 for invalid fields');
        t.truthy(err.response?.body, 'Expected response body for invalid fields');
    }
});




