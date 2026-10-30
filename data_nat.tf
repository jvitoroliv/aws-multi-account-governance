# data_nat.tf
# Manages data source lookups resources.

# Single NAT per VPC — cost optimization. HA NAT (one per AZ) reserved for production.
data "aws_nat_gateway" "production_us_private-1a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.production.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-production-vpc-us-east-1a"]
  }
  /*filter {
    name   = "availability-zone-id"
    values = ["use1-az1"]
  }*/
}

data "aws_nat_gateway" "staging_us_private-1a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.staging.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-staging-vpc-us-east-1a"]
  }

  depends_on = [module.aws_vpc_staging]
}

data "aws_nat_gateway" "shared_us_private-1a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-shared-vpc-us-east-1a"]
  }
  /*filter {
    name   = "availability-zone-id"
    values = ["use1-az1"]
  }*/
}