# Module: S3 Frontend Hosting
# Purpose: Provides a secure, private S3 bucket for hosting static frontend assets.
# Architecture: Static Site Origin - Secure bucket with no public access.
# Intended Integration: CloudFront OAC will be configured to access this bucket.

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = var.tags
}

# Enables static website hosting when temporary hosting is enabled.
resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.enable_website_hosting ? 1 : 0
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Enables versioning for auditability and recovery.
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enforces encryption at rest using AES256.
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Blocks all public access to the bucket to ensure it remains private, except when website hosting is enabled.
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.enable_website_hosting ? false : true
  block_public_policy     = var.enable_website_hosting ? false : true
  ignore_public_acls      = var.enable_website_hosting ? false : true
  restrict_public_buckets = var.enable_website_hosting ? false : true
}

# Bucket policy to allow CloudFront OAC access and optional temporary public read.
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {
  # Allow CloudFront OAC access
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [var.cloudfront_distribution_arn]
    }
  }

  # Add temporary public read statement if website hosting is enabled
  dynamic "statement" {
    for_each = var.enable_website_hosting ? [1] : []
    content {
      sid       = "PublicReadGetObject"
      actions   = ["s3:GetObject"]
      resources = ["${aws_s3_bucket.this.arn}/*"]
      principals {
        type        = "*"
        identifiers = ["*"]
      }
    }
  }
}
