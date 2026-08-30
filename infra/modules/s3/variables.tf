variable "bucket_name" {
  description = "The globally unique name of the S3 bucket to create for static hosting."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources for billing and governance."
  type        = map(string)
  default     = {}
}

variable "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution to allow access to."
  type        = string
}

variable "enable_website_hosting" {
  description = "Whether to enable static website hosting and public read access temporarily."
  type        = bool
  default     = false
}
