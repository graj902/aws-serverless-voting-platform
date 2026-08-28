variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
}

variable "tags" {
  description = "Mandatory project tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
