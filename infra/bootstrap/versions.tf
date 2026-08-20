# Terraform core and provider requirements for the bootstrap layer.
# Defines the minimum Terraform version and the AWS provider constraints
# to ensure compatibility and stability during infrastructure provisioning.

terraform {
  required_version = ">= 1.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
