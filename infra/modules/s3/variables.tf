variable "bucket_name" {
  description = "The globally unique name of the S3 bucket to create for static hosting."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources for billing and governance."
  type        = map(string)
  default     = {}
}
