# Environment & AWS Region for development environment
environment_name = "dev"
aws_region = "us-east-1"

# VPC Configuration
vpc_cidr = "10.0.0.0/16"

# Subnet Configuration
subnet_newbits = 8

# Tags
tags = {
  Environment = "dev"
  Project     = "Infrastructure"
  Owner       = "DevOps Team"
  CreatedBy   = "Terraform"
  Course      = "AWS Infrastructure as Code"
  Demo        = "VPC and remote backend configuration"
}
