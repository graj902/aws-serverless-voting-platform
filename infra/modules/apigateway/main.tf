# ==============================================================================
# API Gateway: Voting Platform Frontend Interface
# ==============================================================================
# Provisions an HTTP API Gateway with explicit routes and JWT authorization.
#
# Configurations:
# - CORS: Enabled for localhost:5173
# - Integration: Lambda Proxy Integration
# - Auth: Cognito JWT Authorizer for sensitive routes
# ==============================================================================

data "aws_region" "current" {}

resource "aws_apigatewayv2_api" "api" {
  name          = var.api_name
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["http://localhost:5173"]
    allow_methods = ["POST", "GET", "PUT", "DELETE", "OPTIONS"]
    allow_headers = ["Authorization", "Content-Type"]
  }
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}

# Cognito JWT Authorizer
resource "aws_apigatewayv2_authorizer" "cognito" {
  api_id           = aws_apigatewayv2_api.api.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "cognito-authorizer"

  jwt_configuration {
    audience = [var.user_pool_client_id]
    issuer   = "https://cognito-idp.${data.aws_region.current.name}.amazonaws.com/${var.user_pool_id}"
  }
}

# Shared Lambda Integration
resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_invoke_arn
  payload_format_version = "2.0"
}

# Routes with Authorizer
locals {
  protected_routes = [
    "POST /vote",
    "GET /vote",
    "PUT /vote",
    "DELETE /vote"
  ]
}

resource "aws_apigatewayv2_route" "protected_routes" {
  for_each           = toset(local.protected_routes)
  api_id             = aws_apigatewayv2_api.api.id
  route_key          = each.value
  target             = "integrations/${aws_apigatewayv2_integration.lambda.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.cognito.id
  authorization_type = "JWT"
}

# Route without Authorizer
resource "aws_apigatewayv2_route" "public_route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /results"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

# Permissions for API Gateway to invoke Lambda
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
