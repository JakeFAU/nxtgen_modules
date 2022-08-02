variable "role" {
  type        = string
  description = "The role"
}

variable "assume_role_policy_json" {
  type        = string
  description = "Policy JSON"
}

variable "role_policy_arn" {
  type        = string
  description = "Policy ARN"
}
