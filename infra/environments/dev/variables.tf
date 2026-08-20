# Environment-specific input variables.

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "serverless-voting-platform"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}
