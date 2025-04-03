output "security_group_ids" {
  description = "IDs de los Security Groups creados"
  value       = { for k, sg in aws_security_group.sgs : k => sg.id }
}