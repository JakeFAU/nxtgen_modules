# Lambda Layer
output "lambda_layer_arn" {
  description = "The ARN of the Lambda Layer with version"
  value       = aws_lambda_layer_version.lambda_layer.arn
}

output "lambda_layer_layer_arn" {
  description = "The ARN of the Lambda Layer without version"
  value       = aws_lambda_layer_version.lambda_layer.layer_arn
}

output "lambda_layer_created_date" {
  description = "The date Lambda Layer resource was created"
  value       = aws_lambda_layer_version.lambda_layer.created_date
}

output "lambda_layer_source_code_size" {
  description = "The size in bytes of the Lambda Layer .zip file"
  value       = aws_lambda_layer_version.lambda_layer.source_code_size
}

output "lambda_layer_version" {
  description = "The Lambda Layer version"
  value       = aws_lambda_layer_version.lambda_layer.version
}

output "src_code_etag" {
  description = "The ETAG of the src code in the bucket"
  value       = aws_s3_bucket_object.file_upload.etag
}

output "src_code_id" {
  description = "The id of the src code in the bucket"
  value       = aws_s3_bucket_object.file_upload.id
}

