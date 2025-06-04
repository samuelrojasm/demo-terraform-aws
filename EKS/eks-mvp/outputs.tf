output "cluster_name" {
  description = "Nombre del clúster EKS"
  value       = module.eks.cluster_name
}

output "kubeconfig_command" {
  description = "Comando para configurar kubectl con el clúster EKS"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Subredes privadas donde están los nodos EKS"
  value       = module.vpc.private_subnets
}
