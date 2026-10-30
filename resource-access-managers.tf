# resource-access-managers.tf
# Part of the resource-access-managers Terraform configuration module.


// ------------------------------------------Production----------------------------------------------------
resource "aws_ram_resource_share" "ram-production-subnet" {
    name = "ram-production-subnet"
    allow_external_principals = false
    tags ={
        Terraform = "true"
        Environment = "production"

    }
}

resource "aws_ram_resource_association" "ram-subnet-association-1a-public" {
  resource_arn = module.aws_vpc_production.public_subnet_arns[0] //clientproject-prodution-vpc-public-us-east-1a
  resource_share_arn = aws_ram_resource_share.ram-production-subnet.arn
}

resource "aws_ram_resource_association" "ram-subnet-association-1a-private" {
  resource_arn = module.aws_vpc_production.private_subnet_arns[0] //clientproject-prodution-vpc-private-us-east-1a // Trocar value para Data Source
  resource_share_arn = aws_ram_resource_share.ram-production-subnet.arn
}

resource "aws_ram_resource_association" "ram-subnet-association-1b-public" {
  resource_arn = "arn:aws:ec2:us-east-1:888888888888:subnet/subnet-0example000000001" //clientproject-prodution-vpc-public-us-east-1b // Trocar value para Data Source
  resource_share_arn = aws_ram_resource_share.ram-production-subnet.arn
}

resource "aws_ram_resource_association" "ram-subnet-association-1b-private" {
  resource_arn = "arn:aws:ec2:us-east-1:888888888888:subnet/subnet-0example000000002" //clientproject-prodution-vpc-private-us-east-1b // Trocar value para Data Source
  resource_share_arn = aws_ram_resource_share.ram-production-subnet.arn
}

resource "aws_ram_principal_association" "production" {
  principal          = "888888888889" // Transformar para Variable
  resource_share_arn = aws_ram_resource_share.ram-production-subnet.arn
}


//---------------------------------------------------------------Staging------------------------------------------------------------------------------
resource "aws_ram_resource_share" "ram-staging-subnet" {
    name = "ram-staging-subnet"
    allow_external_principals = false
    tags ={
        Terraform = "true"
        Environment = "staging"

    }
}

resource "aws_ram_resource_association" "ram-subnet-stg-association-1a-public" {
  resource_arn = module.aws_vpc_staging.public_subnet_arns[0] //clientproject-staging-vpc-public-us-east-1a
  resource_share_arn = aws_ram_resource_share.ram-staging-subnet.arn
}

resource "aws_ram_resource_association" "ram-subnet-stg-association-1a-private" {
  resource_arn = module.aws_vpc_staging.private_subnet_arns[0] //clientproject-staging-vpc-private-us-east-1a // Trocar value para Data Source
  resource_share_arn = aws_ram_resource_share.ram-staging-subnet.arn
}
resource "aws_ram_principal_association" "staging" {
  principal          = "888888888890" // Transformar para Variable
  resource_share_arn = aws_ram_resource_share.ram-staging-subnet.arn
}