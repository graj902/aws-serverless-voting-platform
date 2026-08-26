variable "environment" {
  description = "Environment name (e.g., dev)"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "serverless-voting-platform"
}
