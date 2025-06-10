# Definimos las salidas del módulo

output "ami_id" {
  description = "El ID de la última AMI de Bottlerocket que coincide con los criterios especificados."
  value       = data.aws_ssm_parameter.bottlerocket_ami_id.value
}

output "ssm_parameter_path" {
  description = "La ruta completa del Parameter Store SSM utilizada para obtener el AMI ID."
  value       = local.parameter_path
}