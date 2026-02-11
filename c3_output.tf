 output "aws_s3_bucket_name" {
    value = aws_s3_bucket.demo_bucket
       description = "S3 Bucket name"

 }

 output "aws_s3_bucket_id" {
   value = aws_s3_bucket.demo_bucket.id
      description = "S3 Bucket ID"
 }


  output "aws_s3_bucket_arn" {
   value = aws_s3_bucket.demo_bucket.arn
   description = "S3 Bucket ARN"
 }