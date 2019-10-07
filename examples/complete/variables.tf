
variable "aws_account_id" {
  description = "The aws account id for the tf backend creation (e.g. 857026751867)"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "default"
}

# policies
variable "policy_arn" {
  description = "A list of full arn of iam policy to apply the user"
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
