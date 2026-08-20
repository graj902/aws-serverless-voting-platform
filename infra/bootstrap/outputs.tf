# Outputs for the bootstrap layer.
# Provides critical resource identifiers needed to configure the remote backend
# in subsequent environment deployments.

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket for state storage"
  value       = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  value       = aws_dynamodb_table.terraform_lock.name
}
