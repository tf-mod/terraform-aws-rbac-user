
# iam user module
resource "aws_iam_user" "user" {
  name          = var.name
  path          = "/"
  force_destroy = true

  tags = {
    Description = var.desc
  }
}

# security/password
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# security/policy
resource "aws_iam_user_policy_attachment" "policy" {
  count      = length(var.policy_arn)
  user       = aws_iam_user.user.name
  policy_arn = var.policy_arn[count.index]
}

# group membership
resource "aws_iam_user_group_membership" "groups" {
  user   = aws_iam_user.user.name
  groups = var.groups
}


# login profile
data "template_file" "login-profile" {
  template = file(format("%s/resources/credential.tpl", path.module))

  vars = {
    name = aws_iam_user.user.name
    password  = random_password.password.result
  }
}

locals {
  creds_filepath = format("%s/credentials/%s.json", path.cwd, aws_iam_user.user.name)
}

resource "local_file" "login-profile" {
  sensitive_content  = data.template_file.login-profile.rendered
  filename = local.creds_filepath
  file_permission = "0600"
}

resource "null_resource" "login-profile" {
  provisioner "local-exec" {
    command = <<CLI
aws iam create-login-profile --cli-input-json file://${local.creds_filepath} --profile ${var.aws_profile} --region us-east-1
CLI
  }
}
