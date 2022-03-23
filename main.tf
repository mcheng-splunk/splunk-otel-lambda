
# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_role" {
  name = "role_lambda"

  assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {
         "Service": "lambda.amazonaws.com"
       },
       "Effect": "Allow",
       "Sid": ""
     }
   ]
}
EOF
}

resource "aws_iam_role_policy" "frontend_lambda_role_policy" {
  name   = "frontend-lambda-role-policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_log_and_invoke_policy.json
}

data "aws_iam_policy_document" "lambda_log_and_invoke_policy" {

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]

  }

  statement {
    effect = "Allow"

    actions = ["lambda:InvokeFunction", "lambda:InvokeAsync"]

    resources = ["arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:*"]
  }

}

# **************** Calculator Lambda ****************

data "archive_file" "calculator" {
  type        = "zip"
  source_file = "./src/calculator/calculator.py"
  output_path = "./bin/calculator.zip"
}

resource "aws_lambda_function" "calculator" {
  function_name = "calculator"

  filename         = data.archive_file.calculator.output_path
  source_code_hash = data.archive_file.calculator.output_base64sha256

  role    = aws_iam_role.lambda_role.arn
  handler = "calculator.lambda_handler"
  runtime = "python3.9"
  timeout = 5
}


# **************** Addition Lambda ****************
data "archive_file" "addition" {
  type        = "zip"
  source_file = "./src/calculator/addition/addition.py"
  output_path = "./bin/addition.zip"
}

resource "aws_lambda_function" "addition" {
  function_name = "addition"

  filename         = data.archive_file.addition.output_path
  source_code_hash = data.archive_file.addition.output_base64sha256

  role    = aws_iam_role.lambda_role.arn
  handler = "addition.lambda_handler"
  runtime = "python3.9"
  timeout = 5
}

# **************** Subtraction Lambda ****************
data "archive_file" "subtraction" {
  type        = "zip"
  source_file = "./src/calculator/subtraction/subtraction"
  output_path = "./bin/subtraction.zip"
}

resource "aws_lambda_function" "subtraction" {
  function_name = "subtraction"

  filename         = data.archive_file.subtraction.output_path
  source_code_hash = data.archive_file.subtraction.output_base64sha256

  role    = aws_iam_role.lambda_role.arn
  handler = "subtraction"
  runtime = "go1.x"
  timeout = 5
}

# **************** Multiply Lambda ****************
data "archive_file" "multiply" {
  type        = "zip"
  source_dir  = "./src/calculator/multiply"
  output_path = "./bin/multiply.zip"
}

resource "aws_lambda_function" "multiply" {
  function_name = "multiply"

  filename         = data.archive_file.multiply.output_path
  source_code_hash = data.archive_file.multiply.output_base64sha256

  role    = aws_iam_role.lambda_role.arn
  handler = "multiply.handler"
  runtime = "nodejs12.x"
  timeout = 5
}

# **************** Division Lambda ****************

resource "aws_lambda_function" "division" {
  function_name = "division"

  filename         = var.division_payload_filename
  source_code_hash = filebase64sha256(var.division_payload_filename)

  role    = aws_iam_role.lambda_role.arn
  handler = "com.calculator.division::handleRequest"
  runtime = "java8"
  timeout = 5
}
