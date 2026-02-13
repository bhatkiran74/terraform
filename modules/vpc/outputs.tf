output "vpc_id" {

  value       = aws_vpc.main.id
  description = "The VPC ID"

}


output "public_subnet_id" {
  value       = [for subnet in aws_subnet.public : subnet.id]
  description = "List of public subnet IDs"

}

output "private_subnet_id" {
  value       = [for subnet in aws_subnet.private : subnet.id]
  description = "List of private subnet IDs"

}


output "public_subnet_map" {
  value       = { for subnet in aws_subnet.public : subnet.availability_zone => subnet.id }
  description = "Map of availability zone to public subnet ID"

}
