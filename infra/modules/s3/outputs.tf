output "bucket_name" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.this.bucket
}

output "bucket_arn" {
  description = "The ARN of the bucket, used for policy definition."
  value       = aws_s3_bucket.this.arn
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name, used for origin configuration."
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
