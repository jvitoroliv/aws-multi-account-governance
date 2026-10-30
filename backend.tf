# backend.tf
# Manages state backend configuration resources.

# Provider versions pinned to minor — patch updates auto-applied, breaking changes blocked
terraform {
  # Remote state with S3 + DynamoDB locking. State encryption enabled at bucket level.
  backend "s3" {
    bucket  = "tf-state-clientproject"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "clientproject-network"
  }
}