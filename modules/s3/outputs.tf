output "bucket_name" {
  value = aws_s3_bucket.files_bucket.bucket
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.files_bucket.arn
}

output "bucket_region" {
  description = "The region of the S3 bucket"
  value       = aws_s3_bucket.files_bucket.region
}

output "bucket_tags" {
  description = "The tags of the S3 bucket"
  value       = aws_s3_bucket.files_bucket.tags
}

output "bucket_domain_name" {
  description = "The domain name of the S3 bucket"
  value       = aws_s3_bucket.files_bucket.bucket_domain_name
}

output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.files_bucket.id
}
