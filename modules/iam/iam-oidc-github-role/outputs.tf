output "role_info" {
  description = "Nombre del rol IAM creado"
  value       = aws_iam_role.this
}

output "policy_info" {
  description = "Atributos de la política personalizada (si fue creada)"
  value = {
    for k, policy in aws_iam_policy.this :
    k => {
      id        = policy.id
      name      = policy.name
      arn       = policy.arn
      path      = policy.path
      policy    = policy.policy
      tags      = policy.tags
      policy_id = policy.policy_id
    }
  }
}

output "policy_info_all" {
  description = "Atributos completos de la política personalizada (si fue creada)"
  value       = aws_iam_policy.this
}