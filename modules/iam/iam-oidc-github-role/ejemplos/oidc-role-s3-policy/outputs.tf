output "role_arn" {
  description = "ARN of the IAM role created"
  value       = aws_iam_role.github_actions_policy.arn
}
