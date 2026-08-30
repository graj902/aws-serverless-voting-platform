# Module: S3 Frontend Hosting
# Purpose: Provides a secure, private S3 bucket for hosting static frontend assets.
# Architecture: Static Site Origin - Secure bucket with no public access.
# Intended Integration: CloudFront OAC will be configured to access this bucket.

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = var.tags
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

# Blocks all public access to the bucket to ensure it remains private.
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
