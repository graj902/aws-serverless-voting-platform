# Input variables for bootstrap infrastructure.
# Defines standardized configuration parameters used across the bootstrap layer
# to maintain consistency and ease of deployment.

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "serverless-voting-platform"
}

variable "owner" {
  description = "Resource owner"
  type        = string
  default     = "Gururaj"
}

# Local variables to centralize and standardize tagging across all resources.
# This ensures compliance with project standards for resource tracking and cost allocation.

locals {
  common_tags = {
    Project     = var.project
    ManagedBy   = "Terraform"
    Environment = var.environment
    Owner       = var.owner
  }
}
