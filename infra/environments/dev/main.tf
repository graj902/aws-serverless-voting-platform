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

module "iam" {
  source       = "../../modules/iam"
  environment  = var.environment
  project_name = var.project_name
}

module "cognito" {
  source        = "../../modules/cognito"
  environment   = var.environment
  tags          = local.common_tags
  callback_urls = ["http://localhost:5173"]
  logout_urls   = ["http://localhost:5173"]
}
