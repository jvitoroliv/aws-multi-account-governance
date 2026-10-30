# instances.tf
# Part of the instances Terraform configuration module.

# Shared module — changes here affect all consumers. Semver applies.
# Module sourced from internal registry — pin version to prevent unexpected changes
module "ec2_instance" {
  source  = "git@ssh.dev.azure.com:v3/example-org/tf-module-ec2/tf-module-ec2"
  name = "exemplo"

  instance_type          = "t2.micro"
  key_name               = "clientproject-key-staging"
  monitoring             = false
  vpc_security_group_ids = ["sg-079361accc994c970"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}