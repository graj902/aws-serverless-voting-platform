variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "lambda_arn" {
  description = "The ARN of the backend Lambda function"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "The Invoke ARN of the backend Lambda function"
  type        = string
}

variable "user_pool_id" {
  description = "The Cognito User Pool ID"
  type        = string
}

variable "user_pool_client_id" {
  description = "The Cognito App Client ID"
  type        = string
}

variable "tags" {
  description = "Mandatory project tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
