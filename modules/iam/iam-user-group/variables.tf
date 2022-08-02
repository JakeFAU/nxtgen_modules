variable "user_name" {
  type        = string
  description = "The User Name"
}

variable "user_groups" {
  type        = list(string)
  description = "Groups for the user"
}
