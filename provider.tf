# provider.tf
# Part of the provider Terraform configuration module.

# Provider versions pinned to minor — patch updates auto-applied, breaking changes blocked
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  # Configuration options
  alias   = "clientproject-shared"
  region  = "us-east-1"
  profile = "clientproject-shared"
}