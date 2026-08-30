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

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3.bucket_arn
}

output "s3_bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  value       = module.s3.bucket_regional_domain_name
}

output "s3_website_endpoint" {
  description = "The website endpoint of the S3 bucket if hosting is enabled"
  value       = module.s3.website_endpoint
}

output "github_actions_role_arn" {
  description = "The ARN of the IAM role for GitHub Actions."
  value       = module.github_actions_oidc.role_arn
}
