## 🛠️ Terraform - Módulo - Busca AMI de Amazon Linux 2023

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Para usar **Amazon Linux 2023 (AL2023)** en Terraform, lo recomendable es obtener la AMI de forma dinámica usando el data source aws_ami, ya que los IDs cambian según la región y el tiempo.
- Obtener dinámicamente la última **AMI de Amazon Linux 2023**, con soporte para arquitectura (x86_64 o arm64) y región.
- Utiliza el kernel predeterminado que Amazon considera estable en ese momento.
- Ideal si quieres automatizar usando **"la última versión recomendada"** sin preocuparte por detalles del kernel.

---

## 🔧 Variables del módulo

| Nombre                | Tipo         | Valor Default         |
|-----------------------|--------------|-----------------------|
| `architecture`        | string       | x86_64                |

---

## 🧪 Ejemplo de uso (main.tf del root project)
### --- Ejemplo de uso para obtener la última AMI de Amazon Linux 2023 (x86_64) ---
```hcl
module "latest_al2023_x86_64_ami" {
  source = "./modules/ami-amazon-linux-2023"
  # architecture se usará el valor por defecto "x86_64" si no se especifica.
}

output "al2023_x86_64_ami_id" {
  value = module.latest_al2023_x86_64_ami.ami_id
}

output "al2023_x86_64_ssm_path" {
  value = module.latest_al2023_x86_64_ami.ssm_parameter_path
}
```
### --- Ejemplo de uso para obtener la última AMI de Amazon Linux 2023 (arm64) ---
```hcl
module "latest_al2023_arm64_ami" {
  source = "./modules/ami-amazon-linux-2023"
  architecture = "arm64"
}

output "al2023_arm64_ami_id" {
  value = module.latest_al2023_arm64_ami.ami_id
}

output "al2023_arm64_ssm_path" {
  value = module.latest_al2023_arm64_ami.ssm_parameter_path
}
```

---

## 📌 Llamada a parámetros públicos de AMI en Parameter Store
### 1.- Primer paso investigar la estructura de las jerarquía de los Parámtros
#### Ejempo Amazon Linux - AMIs
- AMIs publicadas en Parameter Store
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ami-amazon-linux-latest \
        --region us-west-2 \
        --profile tf
    ```
- Lista el Valor dentro de Parameter Store
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ami-amazon-linux-latest \
        --recursive \
        --query "Parameters[*].[Name,Value]" \
        --region us-west-2 \
        --profile tf \
        --output table
    ```
#### Ejemplo ECS – AMIs optimizadas
- Lista nombres de AMIs de amazon-linux-2023
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ecs/optimized-ami/amazon-linux-2023 \
        --recursive \
        --query "Parameters[?contains(Name, 'x86_64') && contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```

###  2.- Segundo paso obtener el ID del AMI
#### Ejempo Amazon Linux AMI ID
```bash 
aws ssm get-parameter \
  --name /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64 \
  --query "Parameter.Value" \
  --output text \
  --region us-west-2 \
  --profile tf
```

```bash
aws ssm get-parameter \
  --name /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64 \
  --query "Parameter.Value" \
  --region us-west-2 \
  --profile tf
```

#### Ejempo ECS - AMIs optimizadas
- AMI ID recomendada para arquitectura x86_64
    ```bash
    aws ssm get-parameter \
        --name /aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id \
        --query "Parameter.Value" \
        --output text \
        --region us-west-2 \
        --profile tf
    ```
- También se puede obtener el AMI ID de:
    ```bash
    "/aws/service/ecs/optimized-ami/amazon-linux-2023/gpu/recommended/image_id"
    "/aws/service/ecs/optimized-ami/amazon-linux-2023/arm64/recommended/image_id"
    "/aws/service/ecs/optimized-ami/amazon-linux-2023/neuron/recommended/image_id"
    ```
---
 
## 📚 Referencias
- [Calling AMI public parameters in Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-public-parameters-ami.html)
- [Reference the latest AMIs using Systems Manager public parameters](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami-parameter-store.html)
- [Resource: aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)
- [Receive notifications on new updates](https://docs.aws.amazon.com/linux/al2023/ug/receive-update-notification.html)

---