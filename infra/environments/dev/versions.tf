# Terraform core and provider requirements for the environment layer.
# Aligns with project standards for version constraints.

terraform {
  required_version = ">= 1.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
