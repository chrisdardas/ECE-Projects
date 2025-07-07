var ResponsePayload = function (code, payload) {
  this.code = code;
  this.payload = payload;
};

exports.respondWithCode = function (code, payload) {
  return new ResponsePayload(code, payload);
};

// Helper function to determine the response code
function getResponseCode(arg1, arg2) {
  if (arg2 && Number.isInteger(arg2)) {
    return arg2;
  }
  if (arg1 && Number.isInteger(arg1)) {
    return arg1;
  }
  // Default to 200 if no code is provided
  return 200;
}

// Helper function to determine the payload
function getPayload(arg1) {
  return arg1 || {};
}

// Helper function to format payload
function formatPayload(payload) {
  if (typeof payload === 'object') {
    return JSON.stringify(payload, null, 2);
  }
  return payload;
}

var writeJson = (exports.writeJson = function (response, arg1, arg2) {
  if (arg1 && arg1 instanceof ResponsePayload) {
    writeJson(response, arg1.payload, arg1.code);
    return;
  }

  const code = getResponseCode(arg1, arg2);
  const payload = formatPayload(getPayload(arg1));

  response.writeHead(code, { 'Content-Type': 'application/json' });
  response.end(payload);
});
