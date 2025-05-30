resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::${var.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            # aud (audience): verifica que el token esté dirigido a sts.amazonaws.com, asegurando que sea un token para asumir roles.
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          },
          StringLike = {
            # sub (subject): restringe a un repositorio y rama específicos.
            # Es posible duplicar condiciones sub si es necesario permitir varios branches (ej: main, dev).
            "token.actions.githubusercontent.com:sub" = "repo:${var.repo_owner}/${var.repo_name}:ref:refs/heads/${var.repo_branch}"
          }
        }
      }
    ]
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
