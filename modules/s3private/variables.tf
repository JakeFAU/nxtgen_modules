variable "bucket_name" {
  description = "Bucket Name"
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "versioning_status" {
  description = "Versioning status"
  type        = string
  default     = "Enabled"
}
