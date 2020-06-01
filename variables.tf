
# features
variable "features" {
  description = "A configuration map for feature toggle"
  default     = { "login" = "off" }
}

# policies
variable "policy_arn" {
  description = "A list of full arn of iam policy to apply the user"
  default     = []
}

# group membership
variable "groups" {
  description = "A list of group names to which the user belongs"
  default     = []
}

# description
variable "name" {
  description = "The logical name of user"
  default     = "default"
}

variable "desc" {
  description = "The extra description of user"
  default     = "Managed by Terraform"
}

variable "password_policy" {
  description = "The policy of password string"
  default     = { "length" = 16 }
}
