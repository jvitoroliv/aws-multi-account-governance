# outputs.tf
# Part of the output value definitions module.

output "annotation" {
  description = "Service account annotation"
  value       = module.aws_vpc_production.private_subnet_arns[0]
}
output "debug-subnets" {
  value = data.aws_subnets.production_us_public-1a
}