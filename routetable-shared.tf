# routetable-shared.tf
# Manages routetable-shared Terraform configuration resources.


resource "aws_route_table" "clientproject-shared-vpc-public" {
  vpc_id = module.aws_vpc_shared.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0a59ef7b52d8669f8"  // Trocar para o Data Source de IGW
  }

  tags = {
    Terraform = "true"
    Environment = "production"
    Name = "clientproject-prodution-vpc-private"
  }
}

resource "aws_route_table" "clientproject-shared-vpc-private" {
  vpc_id = module.aws_vpc_shared.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    # Single NAT per VPC — cost optimization. HA NAT (one per AZ) reserved for production.
    nat_gateway_id = "nat-04c9524af37351afb" // Trocar para o Data Source de NAT
  }

  tags = {
    Terraform = "true"
    Environment = "shared"
    Name = "clientproject-shared-vpc-private"
  }
}
