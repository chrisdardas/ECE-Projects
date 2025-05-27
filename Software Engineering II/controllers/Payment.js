'use strict';  // Enforce use of strict verion of JavaScript

var utils = require('../utils/writer.js'); // Import writer module
var Payment = require('../service/PaymentService'); // Import Payment service module

module.exports.payBookingFee = function payBookingFee (_, res, next, body) {
  //console.log('Received body: ', body);
  const { cardHolderName, cardNumber, CVC, expirationDate } = body;
  if (!cardHolderName || !cardNumber || !CVC || !expirationDate) {
    const error = { message: 'Missing required field: ' };
    
    if (!cardHolderName) error.message += 'cardHolderName ';
    if (!cardNumber) error.message += 'cardNumber ';
    if (!CVC) error.message += 'CVC ';
    if (!expirationDate) error.message += 'expirationDate ';
    
    console.log(error);
    return utils.writeJson(res, error, 400);  // Return error with 400 status code
  }

  // New validation for overly long cardHolderName
  if (cardHolderName.length > 255) {
      return utils.writeJson(res, { message: 'Cardholder name is too long' }, 400);
  }
  // New validation for overly long cardNumber
  if(!isValidCardHolderName(body.cardHolderName)){
    return utils.writeJson(res, {message: 'Invalid Card Holder Name'}, 400);
  }
  // New validation for overly long cardNumber
  if(!isValidCardNumber(body.cardNumber)){
    return utils.writeJson(res, {message: 'Invalid Card number'}, 400);
  }
  // New validation for overly long CVC
  if(!isValidCVC(body.CVC)){
    return utils.writeJson(res, {message:'Invalid CVC'}, 400);
  }
  // New validation for overly long expirationDate
  if(!isValidDate(body.expirationDate)){
    return utils.writeJson(res, {message: 'Invalid Date'}, 400);
  }
  // Call the service function to pay the booking fee
  Payment.payBookingFee(body)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
    next();
};
// Function to handle the payment of the booking fee
module.exports.wrongMethod = function wrongMethod(_, res) {
  res.status(405).json({message: "Method not allowed"});
}
// Function to handle the payment of the booking fee
function isValidCardHolderName(cardHolderName){
  const regex = /^[A-Za-z\s]+$/;
  return regex.test(cardHolderName);
}
// Function to handle the payment of the booking fee
function isValidCardNumber(cardNumber) {
  const regex = /^\d{16}$/;
  return regex.test(cardNumber);
}
// Function to handle the payment of the booking fee
function isValidCVC(CVC){
  return Number.isInteger(CVC) && CVC >= 100 && CVC <= 999;
}
// Function to handle the payment of the booking fee
function isValidDate(expirationDate){
  const regex = /^(0[1-9]|1[0-2])\/\d{4}$/;
  return regex.test(expirationDate);
}