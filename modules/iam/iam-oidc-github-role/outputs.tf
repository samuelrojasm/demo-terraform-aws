output "role_info" {
  description = "Información detallada del IAM Role"
  value = {
    name        = aws_iam_role.this.name
    arn         = aws_iam_role.this.arn
    id          = aws_iam_role.this.id
    path        = aws_iam_role.this.path
    unique_id   = aws_iam_role.this.unique_id
    create_date = aws_iam_role.this.create_date
  }
}

output "policy_info" {
  description = "Details of the IAM policy"
  value = {
    name = aws_iam_policy.this.name
    arn  = aws_iam_policy.this.arn
    id   = aws_iam_policy.this.id
  }
}
