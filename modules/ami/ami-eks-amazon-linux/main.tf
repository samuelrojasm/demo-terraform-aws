# Construimos la lógica para la ruta del Parameter Store.
# La ruta para las AMIs optimizadas de EKS sigue un patrón como:
# /aws/service/eks/optimized-ami/<KUBERNETES_VERSION>/<AMI_FAMILY>/<ARCHITECTURE>/<AMI_TYPE>/recommended/image_id
# Por ejemplo:
# /aws/service/eks/optimized-ami/1.29/amazon-linux-2023/x86_64/standard/recommended/image_id
# /aws/service/eks/optimized-ami/1.29/amazon-linux-2023/x86_64/nvidia/recommended/image_id
# /aws/service/eks/optimized-ami/1.29/amazon-linux-2023/x86_64/neuron/recommended/image_id

locals {
  ami_family = "amazon-linux-2023"

  # Construir el nombre completo del parámetro en el Parameter Store.
  # Utiliza las variables para dinamizar la ruta.
  ami_parameter_names = {
    standard = "/aws/service/eks/optimized-ami/${var.kubernetes_version}/${local.ami_family}/${var.architecture}/standard/image_id"
    nvidia   = "/aws/service/eks/optimized-ami/${var.kubernetes_version}/${local.ami_family}/${var.architecture}/nvidia/image_id"
    neuron   = "/aws/service/eks/optimized-ami/${var.kubernetes_version}/${local.ami_family}/${var.architecture}/neuron/image_id"
  }
}

# Obtener el valor del parámetro (que es el AMI ID) del Parameter Store
data "aws_ssm_parameter" "eks_optimized_ami_id" {
  name = local.ami_parameter_names[var.ami_type]
}