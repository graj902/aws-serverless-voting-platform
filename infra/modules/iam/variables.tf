variable "environment" {
  description = "Environment name (e.g., dev)"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "serverless-voting-platform"
}

variable "table_arn" {
  description = "ARN of the DynamoDB table"
  type        = string
}

variable "gsi_arn" {
  description = "ARN of the DynamoDB GSI"
  type        = string
}
