## 🛠️ Terraform - Módulo - AMI de Amazon Linux optimizada para Amazon EKS
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Obtener la última AMI optimizada para EKS, basada exclusivamente en Amazon Linux 2023, desde el SSM Parameter Store.
- Este módulo se centrará en obtener la AMI de Amazon Linux optimizada para Amazon EKS, que sigue una convención de nombres de Parameter Store ligeramente diferente a la AMI de Amazon Linux 2023 general o las AMIs de Bottlerocket.

---

## 🔧 Variables del módulo

| Nombre                | Tipo    | Valor Default  |
|-----------------------|---------|----------------|
| `kubernetes_version`  | string  | -              |
| `architecture`        | string  | x86_64         |
| `ami_type`            | string  | standard       |

---

## 🧪 Ejemplo de uso (main.tf del root project)
### --- Obtener la AMI estándar para EKS ---
```hcl
module "eks_al2023_standard_ami" {
  source = "./modules/ami-eks-amazon-linux"
  kubernetes_version = "1.29"
  ami_type = "standard"
}

output "eks_al2023_standard_ami_id" {
  value = module.eks_al2023_standard_ami.ami_id
}
output "eks_al2023_standard_ssm_path" {
  value = module.eks_al2023_standard_ami.ssm_parameter_path
}
```
### --- Obtener la AMI con soporte NVIDIA para EKS ---
```hcl
module "eks_al2023_nvidia_ami" {
  source = "./modules/ami-eks-amazon-linux"
  kubernetes_version = "1.29"
  ami_type = "nvidia"
}

output "eks_al2023_nvidia_ami_id" {
  value = module.eks_al2023_nvidia_ami.ami_id
}
output "eks_al2023_nvidia_ssm_path" {
  value = module.eks_al2023_nvidia_ami.ssm_parameter_path
}
```
### --- Obtener la AMI con soporte Neuron para EKS ---
```hcl
module "eks_al2023_neuron_ami" {
  source = "./modules/ami_eks_amazon_linux"
  kubernetes_version = "1.29"
  ami_type = "neuron"
}

output "eks_al2023_neuron_ami_id" {
  value = module.eks_al2023_neuron_ami.ami_id
}
output "eks_al2023_neuron_ssm_path" {
  value = module.eks_al2023_neuron_ami.ssm_parameter_path
}
```

---

## 📌 Llamada a parámetros públicos de AMI en Parameter Store
### 1.- Primer paso investigar la estructura de las jerarquía de los Parámetros
#### Ejemplos Amazon EKS – AMIs optimizadas
- Especifica la versión de Kubernetes y el tipo de AMI que te interesa. 
- Esto reducirá drásticamente la cantidad de resultados y hará que `--output table` sea viable.
- Reemplazar `1.29` por la versión que estés usando en tu clúster EKS.
- Con esto se puede visualizar la estructura **llave-valor** que contiene campo "Value" del Parámetro
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/eks/optimized-ami/1.29/amazon-linux-2023/x86_64 \
        --recursive \
        --query "Parameters[*].[Name,Value]" \
        --region us-east-1 \
        --profile tf \
        --output table
    ```
- JMESPath en el argumento --query:
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/eks/optimized-ami/1.29/amazon-linux-2023/x86_64 \
        --recursive \
        --query 'Parameters[].{Name:Name, Value:Value}' \
        --region us-east-1 \
        --profile tf \
        --output json
    ```
- Solo los que tengan en el Nombre del Parámetro image_id
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/eks/optimized-ami/1.29/amazon-linux-2023/x86_64 \
        --recursive \
       --query "Parameters[?contains(Name, 'image_id')].[Name,Value]" \
        --region us-east-1 \
        --profile tf \
        --output table
    ```
- Listar cierta cantidad de AMIs optimizadas para una versión de Kubernetes en particular
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/eks/optimized-ami/1.29 \
        --recursive \
        --max-items 100 \
        --query "Parameters[?contains(Name, 'image_id')].[Name]" \
        --region us-east-1 \
        --profile tf
    ```

###  2.- Segundo paso obtener el ID del AMI
#### Ejempo AWS EKS AMI ID
- Patrón de nombre de Parameter store
     ```bash
    /aws/service/eks/optimized-ami/<kubernetes-version>/<ami-type>/recommended/image_id
    /aws/service/eks/optimized-ami/<KUBERNETES_VERSION>/<AMI_FAMILY>/<ARCHITECTURE>/<AMI_TYPE>/recommended/image_id
    ```
- AMI ID de versión específica
    ```bash
    aws ssm get-parameter \
        --name /aws/service/eks/optimized-ami/1.29/amazon-linux-2023/x86_64/standard/recommended/image_id \
        --query "Parameter.Value" \
        --output text \
        --region us-west-2 \
        --profile tf
    ```

---

## 📚 Referencias
- [Calling AMI public parameters in Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-public-parameters-ami.html)
- [Reference the latest AMIs using Systems Manager public parameters](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami-parameter-store.html)
- [Resource: aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)
- [Receive notifications on new updates](https://docs.aws.amazon.com/linux/al2023/ug/receive-update-notification.html)
- [View Amazon EKS platform versions for each Kubernetes version](https://docs.aws.amazon.com/es_es/eks/latest/userguide/platform-versions.html)

---
