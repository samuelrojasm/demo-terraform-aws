resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = templatefile("${path.module}/assume-role-policy.tftpl", {
    role_name      = var.role_name
    repo_owner     = var.repo_owner
    repo_name      = var.repo_name
    repo_branch    = var.repo_branch
    aws_account_id = var.aws_account_id
  })
}

resource "aws_iam_policy" "this" {
  name        = "${var.role_name}-policy"
  description = "Policy for GitHub Actions access"

  policy = var.policy_json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
