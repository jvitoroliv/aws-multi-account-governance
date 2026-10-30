# vpc.tf
# Manages VPC networking resources.

resource "aws_eip" "nat" {
  count = 3
  vpc   = true
}

# Module sourced from internal registry — pin version to prevent unexpected changes
module "aws_vpc_staging" {
  source          = "git@ssh.dev.azure.com:v3/example-org/tf-module-vpc/tf-module-vpc"

  name            = "clientproject-${var.environment}-vpc"
  cidr            = "10.123.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.123.0.0/24"]
  private_subnet_names = ["clientproject-stg-private-us-east-1a", "clientproject-stg-private-us-east-1b"]
  public_subnets  = ["10.123.1.0/24"]
  public_subnet_names = ["clientproject-stg-public-us-east-1a", "clientproject-stg-public-us-east-1b"]



  ### Create 1 NAT gateway per AZ
  # Single NAT per VPC — cost optimization. HA NAT (one per AZ) reserved for production.
  enable_nat_gateway        = true
  single_nat_gateway        = true
  one_nat_gateway_per_az    = false
  ### Reuse EIP when VPC destroyed
  reuse_nat_ips             = false                    # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids       = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module
  ### Enabling VPC flow log
  enable_flow_log           = false
  #flow_log_destination_type = "s3"
  #flow_log_destination_arn  = module.bucket_vpc_flow_logs.arn
  ### Enabling VPC DNS Hostname
  #enable_dns_hostnames      = var.default_vpc_enable_dns_hostnames

 /*
  vpc_tags = {
    "kubernetes.io/cluster/ug-eks-${var.environment}" = "shared"
  }

  subnet_tags = {
    "kubernetes.io/cluster/ug-eks-${var.environment}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
*/


  tags = {
    Terraform = "true"
    Environment = "staging"
  }
}

module "aws_vpc_shared" {
  source          = "git@ssh.dev.azure.com:v3/example-org/tf-module-vpc/tf-module-vpc"

  name            = "clientproject-shared-vpc"
  cidr            = "10.125.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.125.0.0/24"]
  private_subnet_names = ["clientproject-shared-private-us-east-1a", "clientproject-shared-private-us-east-1b"]
  public_subnets  = ["10.125.1.0/24"]
  public_subnet_names = ["clientproject-shared-public-us-east-1a", "clientproject-shared-public-us-east-1b"]






  ### Create 1 NAT gateway per AZ
  enable_nat_gateway        = true
  single_nat_gateway        = true
  one_nat_gateway_per_az    = false
  ### Reuse EIP when VPC destroyed
  reuse_nat_ips             = false                    # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids       = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module
  ### Enabling VPC flow log
  enable_flow_log           = false
  #flow_log_destination_type = "s3"
  #flow_log_destination_arn  = module.bucket_vpc_flow_logs.arn
  ### Enabling VPC DNS Hostname
  #enable_dns_hostnames      = var.default_vpc_enable_dns_hostnames

 /*
  vpc_tags = {
    "kubernetes.io/cluster/ug-eks-${var.environment}" = "shared"
  }

  subnet_tags = {
    "kubernetes.io/cluster/ug-eks-${var.environment}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
*/


  tags = {
    Terraform = "true"
    Environment = "shared"
  }
}

module "aws_vpc_production" {
  source          = "git@ssh.dev.azure.com:v3/example-org/tf-module-vpc/tf-module-vpc"

  name            = "clientproject-production-vpc"
  cidr            = "10.124.0.0/16"

  azs             = ["us-east-1a","us-east-1b"]
  private_subnets = ["10.124.0.0/24","10.124.2.0/24"]
  private_subnet_names = ["clientproject-production-private-us-east-1a", "clientproject-production-private-us-east-1b"]
  public_subnets  = ["10.124.1.0/24","10.124.3.0/24"]
  public_subnet_names = ["clientproject-production-public-us-east-1a", "clientproject-production-public-us-east-1b"]  





  ### Create 1 NAT gateway per AZ
  enable_nat_gateway        = true
  single_nat_gateway        = true
  one_nat_gateway_per_az    = false
  ### Reuse EIP when VPC destroyed
  reuse_nat_ips             = false                    # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids       = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module
  ### Enabling VPC flow log
  enable_flow_log           = false
  #flow_log_destination_type = "s3"
  #flow_log_destination_arn  = module.bucket_vpc_flow_logs.arn
  ### Enabling VPC DNS Hostname
  #enable_dns_hostnames      = var.default_vpc_enable_dns_hostnames

 /*
  vpc_tags = {
    "kubernetes.io/cluster/ug-eks-${var.environment}" = "shared"
  }

  subnet_tags = {
    "kubernetes.io/cluster/ug-eks-${var.environment}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
*/


  tags = {
    Terraform = "true"
    Environment = "production"
  }
}

