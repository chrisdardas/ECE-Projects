const http = require('http');   //import http module
const test = require('ava');	//import the ava framework used for running tests
const got = require('got');		//import got module for making requests

const app = require( "../index.js") //import the app from the index.js file

test("Test passes", (t) => {
	t.pass();
});

// Testing the asynchronous messages of our server
test('Async' , async(t) => {
	const res = Promise.resolve('test');
	t.is(await res, 'test');
}); 

test.before(async (t) => {
	try{
		t.context.server = http.createServer(app); // create the server

		const server = t.context.server.listen(); // Start listening on a random port
	
		const { port } = server.address();	// Get the port the server is listening on
	
		t.context.got = got.extend({responseType: "json", prefixUrl: `http://localhost:${port}`}); // Configure got to target the test server
	} catch(err){
		console.error('Error during setup: ', err);
		throw err; 
	}

});

test.after.always(async (t) => {
	try{
		await t.context.server.close(); 	// Closes the HTTP server created in the setup phase.
	} catch(err) {
		console.error('Error closing the server: ', err);
		throw err;
	}
	
});

module.exports ={
	app, // Export the app
	got: (testInstance) => testInstance.context.got,
};