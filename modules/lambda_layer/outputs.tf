# Lambda Layer
output "lambda_layer_arn" {
  description = "The ARN of the Lambda Layer with version"
  value       = module.lambda_layer_pip_requirements.lambda_layer_arn
}

output "lambda_layer_layer_arn" {
  description = "The ARN of the Lambda Layer without version"
  value       = module.lambda_layer_pip_requirements.lambda_layer_layer_arn
}

output "lambda_layer_created_date" {
  description = "The date Lambda Layer resource was created"
  value       = module.lambda_layer_pip_requirements.lambda_layer_created_date
}

output "lambda_layer_source_code_size" {
  description = "The size in bytes of the Lambda Layer .zip file"
  value       = module.lambda_layer_pip_requirements.lambda_layer_source_code_size
}

output "lambda_layer_version" {
  description = "The Lambda Layer version"
  value       = module.lambda_layer_pip_requirements.lambda_layer_version
}
