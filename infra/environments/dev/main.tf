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
  table_arn    = module.dynamodb.table_arn
  gsi_arn      = "${module.dynamodb.table_arn}/index/destination-index"
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

module "apigateway" {
  source              = "../../modules/apigateway"
  api_name            = "svp-${var.environment}-api"
  lambda_arn          = module.lambda.lambda_function_arn
  lambda_invoke_arn   = module.lambda.lambda_function_invoke_arn # Note: Assuming this output exists, if not, I'll update the module.
  user_pool_id        = module.cognito.user_pool_id
  user_pool_client_id = module.cognito.user_pool_client_id
  tags                = local.common_tags
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = "svp-dev-frontend-059872197670"
  tags        = local.common_tags
}
