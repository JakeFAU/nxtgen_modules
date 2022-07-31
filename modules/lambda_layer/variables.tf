variable "aws_region" {
  type        = string
  description = "The AWS Region"
  default     = "us-east-1"
}

variable "layer_name" {
  type        = string
  description = "The Layer Name"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the layer"
  default     = {}
}

variable "lambda_layer_bucket" {
  type        = string
  description = "The bucket to store the layer in"
}
