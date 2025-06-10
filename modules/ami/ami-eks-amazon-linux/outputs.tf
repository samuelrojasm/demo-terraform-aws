# Aquí definimos la salida del módulo.

output "ami_id" {
  description = "El ID de la AMI de Amazon Linux optimizada para EKS que coincide con los criterios especificados."
  value       = data.aws_ssm_parameter.eks_optimized_ami_id.value
}

output "ssm_parameter_path" {
  description = "La ruta completa del Parameter Store SSM utilizada para obtener el AMI ID."
  value       = data.aws_ssm_parameter.eks_optimized_ami_id.name
}