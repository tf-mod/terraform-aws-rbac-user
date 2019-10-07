# Full example of IAM user for RBAC (Role-Based Access Control)

## Usage
### Create an IAM user to centralized ID account

You can use this module like as below example. In this example, groups is a list of IAM groups to which the user belongs.

```
module "user1" {
  source  = "tf-mod/rbac-user/aws"
  version = "1.0.0"

  name       = "user1"
  desc       = "DevOps Team"
  policy_arn = [aws_iam_policy.force-mfa.arn]
  groups     = ["devops-team"]
}

module "user2" {
  source  = "tf-mod/rbac-user/aws"
  version = "1.0.0"

  name       = "user2"
  desc       = "API Team"
  policy_arn = [aws_iam_policy.force-mfa.arn]
  groups     = ["developer-team"]
}
```
