# Creación del Rol
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

# Creación Política IAM personalizada con los permisos necesarios para que el rol pueda acceder a recursos de AWS
resource "aws_iam_policy" "this" {
  description = "Policy for GitHub Actions access"
  for_each    = var.policy_json != null ? { "this" = var.policy_json } : {}
  name        = "${var.role_name}-policy"
  policy      = each.value
}

# Asocia la política  IAM personalizada (si existe), permitiendo aplicar permisos
resource "aws_iam_role_policy_attachment" "this" {
  for_each   = aws_iam_policy.this
  role       = aws_iam_role.this.name
  policy_arn = each.value.arn
}

# Asocia la política IAM existente con el rol IAM generado, permitiendo aplicar permisos
resource "aws_iam_role_policy_attachment" "existing" {
  for_each   = { for idx, arn in var.policy_arn_list : idx => arn }
  role       = aws_iam_role.this.name
  policy_arn = each.value
}