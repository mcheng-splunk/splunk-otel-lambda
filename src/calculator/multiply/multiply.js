const { v4: uuidv4 } = require('uuid');
exports.handler = async (event, context,callback) => {

    const transactionId = uuidv4(); 
    var operand1 = event.operand1
	var operand2 = event.operand2

    console.log('Lambda B Received event:', JSON.stringify(event, null, 2));
    console.log('operand 1 is ' + operand1 + ' operand 2 is ' + operand2);

    var result = operand1 * operand2
    console.log('result  is ' + result);

    callback (null, {'Result': result, 'Success': 'true', 'TransactionId': transactionId});
  };