output "tfstate_bucket_arn" {
  description = "The ARN of the Terraform state S3 bucket"
  value       = aws_s3_bucket.tfstate_bucket.arn
}


output "tfstate_bucket_id" {
  description = "The ID of the Terraform state S3 bucket"
  value       = aws_s3_bucket.tfstate_bucket.id
}
