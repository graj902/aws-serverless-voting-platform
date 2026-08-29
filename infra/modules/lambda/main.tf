# ==============================================================================
# Lambda Function: Voting Platform Backend API
# ==============================================================================
# Provisions the core Lambda function to handle voting requests.
#
# Configurations:
# - Runtime: Node.js 22.x
# - Memory: 256MB
# - Timeout: 10s
# - Logging: 30-day retention
# - Tracing: AWS X-Ray Active
#
# Architectural Note:
# - source_code_hash ensures Terraform detects code updates in the deployment
#   artifact, triggering proper function updates.
# - Tracing mode "Active" enables distributed tracing for observability.
# ==============================================================================

resource "aws_lambda_function" "vote_api" {
  function_name = var.function_name
  role          = var.iam_role_arn
  runtime       = "nodejs22.x"
  handler       = "index.handler"
  memory_size   = 256
  timeout       = 10

  # Source code artifact
  filename      = "${path.module}/dummy_code.zip"
  source_code_hash = filebase64sha256("${path.module}/dummy_code.zip")
  
  # Enable AWS X-Ray tracing
  tracing_config {
    mode = "Active"
  }
  
  environment {
    variables = {
      TABLE_NAME   = var.table_name
      GSI_NAME     = var.gsi_name
      USER_POOL_ID = var.user_pool_id
      ENVIRONMENT  = var.environment
    }
  }

  tags = merge(
    {
      Name = var.function_name
    },
    var.tags
  )
}

# CloudWatch Log Group with 30-day retention
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 30

  tags = merge(
    {
      Name = "/aws/lambda/${var.function_name}"
    },
    var.tags
  )
}
