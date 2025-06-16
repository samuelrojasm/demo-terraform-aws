# Se implementa la lógica para construir el nombre del parámetro y recuperar el ID de la AMI.

locals {
  ami_parameter_name = (
    var.architecture == "x86_64"
    ? "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
    : "/aws/service/eks/optimized-ami/${var.architecture}/recommended/image_id"
  )
}

# Obtener el valor del parámetro (que es el AMI ID) del Parameter Store.
data "aws_ssm_parameter" "this" {
  name = local.ami_parameter_name
}