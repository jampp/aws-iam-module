output "policy_arns" {
  value = { for p in aws_iam_policy.policy : p.name => p.arn }
}

output "role_arn" {
  value = module.role.iam_role_arn
}
