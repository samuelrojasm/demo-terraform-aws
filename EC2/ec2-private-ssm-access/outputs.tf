#----------------------------------
# Valores de salida del módulo
#----------------------------------

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "IDs de Subredes privadas"
  value       = module.vpc.private_subnets
}