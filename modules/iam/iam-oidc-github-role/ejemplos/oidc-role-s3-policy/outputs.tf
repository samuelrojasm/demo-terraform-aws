output "role_arn" {
  description = "ARN of the IAM role created"
  value       = aws_iam_policy.github_actions_policy.arn
}
