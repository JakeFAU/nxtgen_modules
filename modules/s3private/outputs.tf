output "s3_source_bucket_id" {
  description = "The name of the source bucket."
  value       = aws_s3_bucket.source.bucket
}

output "s3_source_bucket_arn" {
  description = "The ARN of the source bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.source.arn
}

output "s3_source_bucket_bucket_domain_name" {
  description = "The source bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = aws_s3_bucket.source.bucket_domain_name
}

output "s3_source_bucket_bucket_regional_domain_name" {
  description = "The source bucket region-specific domain name."
  value       = aws_s3_bucket.source.bucket_regional_domain_name
}

output "s3_source_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region."
  value       = aws_s3_bucket.source.hosted_zone_id
}

output "s3_source_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = aws_s3_bucket.source.region
}

output "s3_source_log_bucket_id" {
  description = "The name of the source log bucket."
  value       = aws_s3_bucket.source_logs.id
}

output "s3_source_log_bucket_arn" {
  description = "The ARN of the source log bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.source_logs.arn
}

output "s3_destination_bucket_id" {
  description = "The name of the destination bucket."
  value       = aws_s3_bucket.destination.bucket
}

output "s3_destination_bucket_arn" {
  description = "The ARN of the destination bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.destination.arn
}

output "s3_destination_bucket_bucket_domain_name" {
  description = "The destination bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = aws_s3_bucket.destination.bucket_domain_name
}

output "s3_destination_bucket_bucket_regional_domain_name" {
  description = "The destination bucket region-specific domain name."
  value       = aws_s3_bucket.destination.bucket_regional_domain_name
}

output "s3_destination_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region."
  value       = aws_s3_bucket.destination.hosted_zone_id
}

output "s3_destination_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = aws_s3_bucket.destination.region
}

output "s3_destination_log_bucket_id" {
  description = "The name of the destination log bucket."
  value       = aws_s3_bucket.destination_logs.id
}

output "s3_destination_log_bucket_arn" {
  description = "The ARN of the destination log bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.destination_logs.arn
}
