from fnmatch import translate
import json
import uuid


def lambda_handler(event, context):
    # inputForInvoker = {'operand1': 0, 'operand2': 0, 'operator': "+"}
    # 1 Read off the input argument
    operand1 = event['operand1']
    operand2 = event['operand2']
    operator = event['operator']

    # 2 Generate a random id
    transactionId = str(uuid.uuid1())

    # 3 - Do some stuff here e.g save to s3 , write to database, etc...
    result = int(operand1) + int(operand2)

    # 4 -  Format and return response
    return {'Result': result, 'Success': 'true', 'TransactionId': transactionId}
