output "bucket_name" {
  value = aws_s3_bucket.bucket_name.bucket
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket_name.arn
}

output "bucket_region" {
  value       = aws_s3_bucket.bucket_name.region
}

output "bucket_tags" {
  value       = aws_s3_bucket.bucket_name.tags
}

output "bucket_domain_name" {
  value       = aws_s3_bucket.bucket_name.bucket_domain_name
}

output "bucket_id" {
  value = aws_s3_bucket.bucket_name.id
}
