variable "repository_name" {
  description = "The GitHub repository name (e.g., org/repo)."
  type        = string
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket to allow deployment to."
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}
