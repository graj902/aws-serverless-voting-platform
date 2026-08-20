# AWS provider configuration.
# The provider is configured to use the region defined in variables,
# promoting environment portability while defaulting to project standard region.

provider "aws" {
  region = var.aws_region
}
