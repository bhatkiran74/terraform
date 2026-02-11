resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}



resource "aws_s3_bucket" "demo_bucket" {
  bucket = "devops-demo-${random_string.suffix.result}"
  
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}