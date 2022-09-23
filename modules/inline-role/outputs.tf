output "arn" {
  value = aws_iam_role.iam_role.arn
}

output "instance_profile_arn" {
  value = join("", aws_iam_instance_profile.instance_profile.*.arn)
}
