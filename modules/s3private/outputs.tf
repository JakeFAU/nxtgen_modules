output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.self.bucket
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.self.arn
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = aws_s3_bucket.self.bucket_domain_name
}

output "s3_bucket_regional_domain_name" {
  description = "The source bucket region-specific domain name."
  value       = aws_s3_bucket.self.bucket_regional_domain_name
}

output "s3_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region."
  value       = aws_s3_bucket.self.hosted_zone_id
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = aws_s3_bucket.self.region
}

output "s3_log_bucket_id" {
  description = "The name of the log bucket."
  value       = aws_s3_bucket.self_logs.id
}

output "s3_log_bucket_arn" {
  description = "The ARN of the log bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.self_logs.arn
}
