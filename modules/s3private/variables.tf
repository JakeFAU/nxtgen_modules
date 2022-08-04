variable "bucket_name" {
  description = "Bucket Name"
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "aws_region" {
  description = "The AWS Region"
  type        = string
  default     = "us-east-1"
}
