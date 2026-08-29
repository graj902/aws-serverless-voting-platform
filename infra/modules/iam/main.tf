locals {
  common_tags = {
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = var.environment
    Owner       = "Gururaj"
  }
}

# Lambda Trust Policy
data "aws_iam_policy_document" "lambda_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Lambda Execution Role
resource "aws_iam_role" "lambda_role" {
  name               = "svp-${var.environment}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_trust.json
  tags               = local.common_tags
}

# CloudWatch Logs Policy
data "aws_iam_policy_document" "lambda_cw_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_policy" "lambda_cw_policy" {
  name        = "svp-${var.environment}-lambda-cw-policy"
  description = "IAM policy for Lambda to write to CloudWatch Logs"
  policy      = data.aws_iam_policy_document.lambda_cw_policy.json
  tags        = local.common_tags
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "lambda_cw_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_cw_policy.arn
}

# DynamoDB Access Policy
data "aws_iam_policy_document" "lambda_dynamodb_policy" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query"
    ]
    resources = [
      var.table_arn,
      var.gsi_arn
    ]
  }
}

resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "svp-${var.environment}-lambda-dynamodb-policy"
  description = "IAM policy for Lambda to access DynamoDB table and GSI"
  policy      = data.aws_iam_policy_document.lambda_dynamodb_policy.json
  tags        = local.common_tags
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
}
