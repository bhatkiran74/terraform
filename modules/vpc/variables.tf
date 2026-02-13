variable "environment_name" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}


variable "vpc_cidr" {
  description = "CIDR block for the vpc"
  type        = string
  default     = "10.0.0.0/16"
}


variable "tags" {
  description = " global tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform = "true"
  }

}

variable "subnet_newbits" {

  description = "Number of new bits to add to vpc CIDR to generate subnet"
  type        = number
  default     = 8
}
