# Se implementa la lógica para construir el nombre del parámetro y recuperar el ID de la AMI.
# La ruta para la última AMI de Amazon Linux 2023 sigue un patrón como:
# /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64
# /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64

locals {
  ssm_path = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-${var.architecture}"
}

# Obtener el valor del parámetro (que es el AMI ID) del Parameter Store.
data "aws_ssm_parameter" "this" {
  name = local.ssm_path
}