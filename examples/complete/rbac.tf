# Complete example

module "user1" {
  source  = "tf-mod/rbac-user/aws"
  version = "1.0.0"

  name       = var.name
  policy_arn = [aws_iam_policy.force-mfa.arn]
  groups     = ["devops-team"]
}
