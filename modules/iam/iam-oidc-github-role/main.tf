resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = templatefile("${path.module}/assume-role-policy.tpl", {
    oidc_provider_arn = var.oidc_provider_arn
    audience          = var.audience
    repository        = var.repository
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
