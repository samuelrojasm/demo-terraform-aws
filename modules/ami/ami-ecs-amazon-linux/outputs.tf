output "ami_id" {
  description = "El ID de la última AMI de Amazon Linux 2023 para la arquitectura especificada."
  value       = data.aws_ssm_parameter.this.value
}

output "ssm_parameter_path" {
  description = "La ruta completa del Parameter Store SSM utilizada para obtener el AMI ID."
  value       = data.aws_ssm_parameter.this.name
}