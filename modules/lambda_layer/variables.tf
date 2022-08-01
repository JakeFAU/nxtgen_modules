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

variable "arch" {
  type        = string
  description = "The Layer Arch"
  default     = "x86_64"
}

variable "requirements_path" {
  type        = string
  description = "The [path to the requirements file"
  default     = "./src/requirements.txt"
}
