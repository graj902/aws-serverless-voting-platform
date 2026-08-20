# Root configuration for the dev environment.
# Prepares for future module integration by establishing common tags.

locals {
  common_tags = {
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = var.environment
    Owner       = "Gururaj"
  }
}
