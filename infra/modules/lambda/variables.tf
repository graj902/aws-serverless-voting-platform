variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "iam_role_arn" {
  description = "The ARN of the existing IAM role for the Lambda function"
  type        = string
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "gsi_name" {
  description = "The name of the DynamoDB GSI"
  type        = string
}

variable "user_pool_id" {
  description = "The ID of the Cognito User Pool"
  type        = string
}

variable "tags" {
  description = "Mandatory project tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
