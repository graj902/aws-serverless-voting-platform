# Remote backend configuration.
# Configures Terraform to store state in the S3 bucket provisioned by the bootstrap layer.
# DynamoDB is used to manage state locking to prevent concurrent modifications.

terraform {
  backend "s3" {
    bucket         = "svp-tf-state-059872197670"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "svp-tf-lock"
    encrypt        = true
  }
}
