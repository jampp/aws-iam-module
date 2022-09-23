data "aws_caller_identity" "current" {}

resource "aws_iam_role" "iam_role" {
  name = var.role_name
  path = var.role_path

  assume_role_policy = templatefile(var.assume_role_policy_file, merge(
    { account_id = data.aws_caller_identity.current.account_id },
    var.assume_role_policy_vars
  ))

  dynamic "inline_policy" {
    for_each = var.inline_policies

    content {
      name   = inline_policy.key
      policy = templatefile(inline_policy.value.file, inline_policy.value.vars)
    }
  }

  tags = var.tags

}


resource "aws_iam_instance_profile" "instance_profile" {
  count = var.create_instance_profile ? 1 : 0

  name = var.role_name
  role = aws_iam_role.iam_role.name

  tags = var.tags
}
