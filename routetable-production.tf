# routetable-production.tf
# Manages routetable-production Terraform configuration resources.


resource "aws_route_table" "clientproject-prodution-vpc-public" {
  vpc_id = module.aws_vpc_production.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0c36bcf0dfeb149c7"  // Trocar para o Data Source de IGW
  }

  tags = {
    Terraform = "true"
    Environment = "production"
    Name = "clientproject-prodution-vpc-private"
  }
}

resource "aws_route_table" "clientproject-prodution-vpc-private" {
  vpc_id = module.aws_vpc_production.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    # Single NAT per VPC — cost optimization. HA NAT (one per AZ) reserved for production.
    nat_gateway_id = "nat-0b31af542f9ce1812" // Trocar para o Data Source de NAT
  }

  tags = {
    Terraform = "true"
    Environment = "production"
    Name = "clientproject-prodution-vpc-private"
  }
}