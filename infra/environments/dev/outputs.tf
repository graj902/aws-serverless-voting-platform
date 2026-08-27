output "lambda_execution_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = module.iam.lambda_execution_role_arn
}

output "lambda_execution_role_name" {
  description = "Name of the Lambda execution role"
  value       = module.iam.lambda_execution_role_name
}

output "user_pool_id" {
  description = "The ID of the created Cognito User Pool"
  value       = module.cognito.user_pool_id
}

output "user_pool_arn" {
  description = "The ARN of the created Cognito User Pool"
  value       = module.cognito.user_pool_arn
}

output "user_pool_client_id" {
  description = "The ID of the created Cognito User Pool App Client"
  value       = module.cognito.user_pool_client_id
}
