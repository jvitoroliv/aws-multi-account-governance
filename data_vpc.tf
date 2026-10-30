# data_vpc.tf
# Manages data source lookups resources.

data "aws_vpc" "production" {
  filter {
    name   = "tag:Name"
    values = ["clientproject-production*"]
  }
}

data "aws_vpc" "staging" {
  filter {
    name   = "tag:Name"
    values = ["clientproject-staging*"]
  }
}

data "aws_vpc" "shared" {
  filter {
    name   = "tag:Name"
    values = ["clientproject-shared*"]
  }
}