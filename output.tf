output "calculator" {
  value = aws_lambda_function.calculator.qualified_arn
}

output "base_url" {
  value = aws_api_gateway_deployment.apideploy.invoke_url
}
