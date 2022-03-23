import json
import boto3

print('Loading function')

client = boto3.client('lambda')
# response = ""


def lambda_handler(event, context):

    # 1. Parse out query string params
    operand1 = event['queryStringParameters']['operand1']
    operand2 = event['queryStringParameters']['operand2']
    operator = event['queryStringParameters']['operator']

    print('operand1=' + operand1)
    print('operand2=' + operand2)
    print('operator=' + operator)

    #  return {'Result': result, 'Success': 'true', 'TransactionId': transactionId}

    inputForInvoker = {'operand1': operand1,
                       'operand2': operand2, 'operator': operator}

    # invoke additional Lambda function
    if operator == 'add':
        response = client.invoke(
            FunctionName='addition',
            InvocationType='RequestResponse',  # Event
            Payload=json.dumps(inputForInvoker)
        )
    if operator == 'sub':
        response = client.invoke(
            FunctionName='subtraction',
            InvocationType='RequestResponse',  # Event
            Payload=json.dumps(inputForInvoker)
        )

    if operator == 'mul':
        response = client.invoke(
            FunctionName='multiply',
            InvocationType='RequestResponse',  # Event
            Payload=json.dumps(inputForInvoker)
        )

    if operator == 'div':
        response = client.invoke(
            FunctionName='division',
            InvocationType='RequestResponse',  # Event
            Payload=json.dumps(inputForInvoker)
        )

    responseJson = json.load(response['Payload'])

    print('\n')
    print(responseJson)
    print('\n')

    # #3. Construct http response object
    responseObject = {}
    responseObject['statusCode'] = 200
    responseObject['headers'] = {}
    responseObject['headers']['Content-Type'] = 'application/json'
    responseObject['body'] = json.dumps(responseJson)

    # 4. Return the response object
    return responseObject
