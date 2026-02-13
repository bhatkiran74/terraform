terraform {

  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }


  backend "s3" {
    bucket       = "tfstate-dev-us-east-1-n3ycie"
    key          = "dev/vpc/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

}


#Provider block
provider "aws" {
  region = var.aws_region
}
