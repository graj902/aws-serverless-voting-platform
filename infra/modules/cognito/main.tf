# Cognito User Pool for user management
resource "aws_cognito_user_pool" "this" {
  name = "svp-${var.environment}-users"

  # Email-based authentication
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  # Strong password policy: Increased min length to 12
  password_policy {
    minimum_length    = 12
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  # Cognito-managed email service
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  tags = var.tags
}

# Cognito App Client for frontend integration
resource "aws_cognito_user_pool_client" "this" {
  name = "svp-${var.environment}-app-client"

  user_pool_id = aws_cognito_user_pool.this.id

  # Frontend app client requires no secret
  generate_secret = false

  # OAuth 2.0 flow configuration for JWT generation
  # Removed 'implicit' flow; using only 'code' for secure PKCE-based auth
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  callback_urls = var.callback_urls
  logout_urls   = var.logout_urls

  supported_identity_providers = ["COGNITO"]
}
