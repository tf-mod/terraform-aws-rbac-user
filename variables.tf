
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

# credentials
variable "aws_profile" {
  description = "A profile name for aws cli"
  default     = "default"
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
