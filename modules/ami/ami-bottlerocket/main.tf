#  Se implementa la lógica para construir el nombre del parámetro y recuperar la AMI

locals {
  # Obtener el mapa de variantes predeterminado (o personalizado si se pasa)
  variants = var.bottlerocket_variant_map["default"]

  # Construir la parte específica del orquestador
  orchestrator_part = var.orchestrator == "eks" ? "${local.variants.eks_prefix}-${var.kubernetes_version}" : local.variants.ecs_prefix


  # Construir los sufijos adicionales (GPU, FIPS)
  gpu_suffix  = var.gpu_support ? local.variants.gpu_suffix : ""
  fips_suffix = var.fips_support ? local.variants.fips_suffix : ""

  # Construir la ruta completa del Parameter Store
  # Ejemplo: /aws/service/bottlerocket/aws-k8s-1.29-nvidia/x86_64/latest/image_id
  parameter_path = "${local.variants.base_prefix}/${local.orchestrator_part}${local.gpu_suffix}${local.fips_suffix}/${var.architecture}/latest/image_id"
}

data "aws_ssm_parameter" "bottlerocket_ami_id" {
  name = local.parameter_path
}