variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "callback_urls" {
  description = "List of allowed callback URLs for the application"
  type        = list(string)
  default     = []
}

variable "logout_urls" {
  description = "List of allowed logout URLs for the application"
  type        = list(string)
  default     = []
}
