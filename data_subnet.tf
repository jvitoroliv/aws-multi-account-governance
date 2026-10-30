# data_subnet.tf
# Manages data source lookups resources.

# Production - Subnets - Public

data "aws_subnets" "production_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.production.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-production-public-*"]
  }
}


data "aws_subnets" "production_us_public-1a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.production.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-production-public-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az1"]
  }
}

data "aws_subnets" "production_us_public-1b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.production.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-production-public-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az2"]
  }
}

data "aws_subnet" "production_public" {
  for_each = toset(data.aws_subnets.production_public.ids)
  id       = each.value
}

# Production - Subnets - Private

data "aws_subnets" "production_private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.production.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-production-private-*"]
  }
}


data "aws_subnets" "production_us_private-1a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.production.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-production-private-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az1"]
  }
}

data "aws_subnets" "production_us_private-1b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.production.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-production-private-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az2"]
  }
}

data "aws_subnet" "production_private" {
  for_each = toset(data.aws_subnets.production_private.ids)
  id       = each.value
}

# Staging - Subnets - Public

data "aws_subnets" "staging_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.staging.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-staging-public-*"]
  }
}


data "aws_subnets" "staging_us_public-1a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.staging.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-staging-public-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az1"]
  }
}

data "aws_subnets" "staging_us_public-1b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.staging.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-staging-public-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az2"]
  }
}

data "aws_subnet" "staging_public" {
  for_each = toset(data.aws_subnets.staging_public.ids)
  id       = each.value
}

# Production - Subnets - Private

data "aws_subnets" "staging_private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.staging.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-staging-private-*"]
  }
}


data "aws_subnets" "staging_us_private-1a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.staging.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-staging-private-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az1"]
  }
}

data "aws_subnets" "staging_us_private-1b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.staging.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-staging-private-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az2"]
  }
}

data "aws_subnet" "staging_private" {
  for_each = toset(data.aws_subnets.staging_private.ids)
  id       = each.value
}

# Production - Subnets - Public

data "aws_subnets" "shared_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-shared-public-*"]
  }
}


data "aws_subnets" "shared_us_public-1a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-shared-public-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az1"]
  }
}

data "aws_subnets" "shared_us_public-1b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-shared-public-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az2"]
  }
}

data "aws_subnet" "shared_public" {
  for_each = toset(data.aws_subnets.shared_public.ids)
  id       = each.value
}

# shared - Subnets - Private

data "aws_subnets" "shared_private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-shared-private-*"]
  }
}


data "aws_subnets" "shared_us_private-1a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-shared-private-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az1"]
  }
}

data "aws_subnets" "shared_us_private-1b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  filter {
    name   = "tag:Name"
    values = ["clientproject-shared-private-*"]
  }
  filter {
    name   = "availability-zone-id"
    values = ["use1-az2"]
  }
}

data "aws_subnet" "shared_private" {
  for_each = toset(data.aws_subnets.shared_private.ids)
  id       = each.value
}



