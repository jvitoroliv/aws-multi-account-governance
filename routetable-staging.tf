# routetable-staging.tf
# Part of the routetable-staging Terraform configuration module.


resource "aws_route_table" "clientproject-staging-vpc-public" {
  vpc_id = module.aws_vpc_staging.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.staging_us_public.id // Trocar para o Data Source de IGW
  }

  tags = {
    Terraform = "true"
    Environment = "production"
    Name = "clientproject-prodution-vpc-private"
  }
  depends_on = [module.aws_vpc_staging]
}

resource "aws_route_table" "clientproject-staging-vpc-private" {
  vpc_id = module.aws_vpc_staging.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    # Single NAT per VPC — cost optimization. HA NAT (one per AZ) reserved for production.
    nat_gateway_id = data.aws_nat_gateway.staging_us_private-1a.id // Trocar para o Data Source de NAT
  }

  tags = {
    Terraform = "true"
    Environment = "staging"
    Name = "clientproject-staging-vpc-private"
  } 
  depends_on = [module.aws_vpc_staging]
}