
# feature toggle
locals {
  login_on = lookup(var.features, "login", "off") == "on" ? true : false
}

# iam user module
resource "aws_iam_user" "user" {
  name          = var.name
  path          = "/"
  force_destroy = true

  tags = {
    Description = var.desc
  }
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

# security/password
resource "random_password" "password" {
  count            = local.login_on == true ? 1 : 0
  length           = 16
  special          = true
  override_special = "_%@"
}

# login profile
data "template_file" "login-profile" {
  count    = local.login_on == true ? 1 : 0
  template = file(format("%s/resources/credential.tpl", path.module))

  vars = {
    name     = aws_iam_user.user.name
    password = random_password.password[0].result
  }
}

locals {
  creds_filepath = format("%s/credentials/%s.json", path.cwd, aws_iam_user.user.name)
}

resource "local_file" "login-profile" {
  count             = local.login_on == true ? 1 : 0
  sensitive_content = data.template_file.login-profile[0].rendered
  filename          = local.creds_filepath
  file_permission   = "0600"
}

resource "null_resource" "login-profile" {
  depends_on = [local_file.login-profile]
  count      = local.login_on == true ? 1 : 0
  provisioner "local-exec" {
    command = <<CLI
aws iam create-login-profile --cli-input-json file://${local.creds_filepath} --profile ${var.aws_profile} --region us-east-1
CLI
  }
}
