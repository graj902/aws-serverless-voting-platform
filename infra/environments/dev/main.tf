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

module "dynamodb" {
  source      = "../../modules/dynamodb"
  environment = var.environment
  tags        = local.common_tags
}

module "lambda" {
  source        = "../../modules/lambda"
  environment   = var.environment
  function_name = "svp-${var.environment}-vote-api"
  iam_role_arn  = module.iam.lambda_execution_role_arn
  table_name    = module.dynamodb.table_name
  gsi_name      = module.dynamodb.gsi_name
  user_pool_id  = module.cognito.user_pool_id
  tags          = local.common_tags
}
