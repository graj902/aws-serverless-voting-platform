output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = module.lambda.lambda_function_arn
}

output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = module.lambda.lambda_function_name
}

output "api_endpoint" {
  description = "The invocation URL of the API Gateway"
  value       = module.apigateway.api_endpoint
}

output "api_id" {
  description = "The ID of the API Gateway"
  value       = module.apigateway.api_id
}
