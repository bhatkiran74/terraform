output "vpc_id" {

  value       = module.vpc.vpc_id
  description = "The VPC ID"

}


output "public_subnet_id" {
  value       = module.vpc.public_subnet_id
  description = "List of public subnet IDs"

}

output "private_subnet_id" {
  value       = module.vpc.private_subnet_id
  description = "List of private subnet IDs"

}


output "public_subnet_map" {
  value       = module.vpc.public_subnet_map
  description = "Map of availability zone to public subnet ID"

}
