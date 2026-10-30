data "aws_internet_gateway" "production_us_public" {
  #filter {
    #name   = "vpc-id"
    #values = [data.aws_vpc.production.id]
  #}
  filter {
    name   = "tag:Name"
    values = ["clientproject-production-vpc"]
  }
}

data "aws_internet_gateway" "staging_us_public" {
  /*filter {
    name   = "vpc-id"
    values = [data.aws_vpc.staging.id]
  }*/
  filter {
    name   = "tag:Name"
    values = ["clientproject-staging-vpc"]
  }
}

data "aws_internet_gateway" "shared_us_public" {
  /*filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }*/
  filter {
    name   = "tag:Name"
    values = ["clientproject-shared-vpc"]
  }
}