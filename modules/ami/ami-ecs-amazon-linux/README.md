## 🛠️ Terraform - Módulo - Busca AMI de Amazon Linux 2023 para Amazon Elastic Container Service (Amazon ECS)
 
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Obtener dinámicamente la última **AMI de Amazon Linux 2023**, con soporte para Amazon Elastic Container Service (Amazon ECS)
- Utiliza el kernel predeterminado que Amazon considera estable en ese momento.
- Ideal si quieres automatizar usando **"la última versión recomendada"** sin preocuparte por detalles del kernel.
- Para usar **Amazon Linux 2023 (AL2023)** en Terraform, lo recomendable es obtener la AMI de forma dinámica usando el data source aws_ami, ya que los IDs cambian según la región y el tiempo.

---

## 🔧 Variables del módulo

| Nombre                | Tipo         | Valor Default         |Valores posibles                    |
|-----------------------|--------------|-----------------------|------------------------------------|
| `architecture`        | string       | x86_64                | 'x86_64', 'arm64', 'neuron', 'gpu' |

---

## 🧪 Ejemplo de uso (main.tf del root project)
### --- Ejemplo de uso para obtener la última AMI de Amazon Linux 2023 (x86_64) ---
```hcl
module "ecs_latest_al2023_x86_64_ami" {
  source = "./modules/ami/ami-ecs-amazon-linux"
  # architecture se usará el valor por defecto "x86_64" si no se especifica.
}

output "ecs_al2023_x86_64_ami_id" {
  value = module.ecs_latest_al2023_x86_64_ami.ami_id
}

output "ecs_al2023_x86_64_ssm_path" {
  value = module.ecs_atest_al2023_x86_64_ami.ssm_parameter_path
}
```

### --- Ejemplo de uso para obtener la última AMI de Amazon Linux 2023 (arm64) ---
```hcl
module "ecs_latest_al2023_arm64_ami" {
  source = "./modules/ami/ami-ecs-amazon-linux"
  architecture = "arm64"
}

output "ecs_al2023_arm64_ami_id" {
  value = module.ecs_latest_al2023_arm64_ami.ami_id
}

output "ecs_al2023_arm64_ssm_path" {
  value = module.ecs_latest_al2023_arm64_ami.ssm_parameter_path
}
```

---

## ⚙️ Probar módulo local
- Desde el directorio raíz del proyecto Terraform
    ```bash
    terraform plan -var="arm64"
    terraform plan -var="neuron"
    terraform plan -var="gpu"
    ```
- Usando archivo .tfvars
    ```bash
    terraform plan -var-file="test.tfvars"
    ```

---

## 📌 Llamada a parámetros públicos de AMI en Parameter Store
### 1.- Primer paso investigar la estructura de las jerarquía de los Parámtros
#### Ejempo ECS - AMIs optimizadas - Amazon Linux - x86_64
- Latest recommended Amazon ECS-optimized AMI (x86_64)
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ecs/optimized-ami/amazon-linux-2023/recommended \
        --recursive \
        --query "Parameters[?contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```
- Retrieving the metadata of the latest recommended Amazon ECS-optimized AMI (x86_64)
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ecs/optimized-ami/amazon-linux-2023/recommended \
        --recursive \
        --query "Parameters[*].[Name,Value]" \
        --region us-west-2 \
        --profile tf \
        --output table
    ```
#### Ejempo ECS - AMIs optimizadas - Amazon Linux - arm64
- Lista nombres de AMIs de amazon-linux-2023
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ecs/optimized-ami/amazon-linux-2023/arm64/recommended \
        --recursive \
        --query "Parameters[?contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```
- Retrieving the metadata of the latest recommended Amazon ECS-optimized AMI (arm64)
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ecs/optimized-ami/amazon-linux-2023/arm64/recommended \
        --recursive \
        --query "Parameters[*].[Name,Value]" \
        --region us-west-2 \
        --profile tf \
        --output table
    ```
#### Ejempo ECS - AMIs optimizadas - Amazon Linux - Neuron
- Lista nombres de AMIs de amazon-linux-2023
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ecs/optimized-ami/amazon-linux-2023/neuron/recommended \
        --recursive \
        --query "Parameters[?contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```
- Retrieving the metadata of the latest recommended Amazon ECS-optimized AMI (neuron)
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ecs/optimized-ami/amazon-linux-2023/neuron/recommended \
        --recursive \
        --query "Parameters[*].[Name,Value]" \
        --region us-west-2 \
        --profile tf \
        --output table
    ```
#### Ejempo ECS - AMIs optimizadas - Amazon Linux - GPU
- Lista nombres de AMIs de amazon-linux-2023
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ecs/optimized-ami/amazon-linux-2023/gpu/recommended \
        --recursive \
        --query "Parameters[?contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```
- Retrieving the metadata of the latest recommended Amazon ECS-optimized AMI (GPU)
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/ecs/optimized-ami/amazon-linux-2023/gpu/recommended \
        --recursive \
        --query "Parameters[*].[Name,Value]" \
        --region us-west-2 \
        --profile tf \
        --output table
    ```

###  2.- Segundo paso obtener el ID del AMI
#### Ejempo Amazon Linux AMI ID
- AMI ID recomendada para arquitectura x86_64
    ```bash 
    aws ssm get-parameter \
    --name /aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id \
    --query "Parameter.Value" \
    --output text \
    --region us-west-2 \
    --profile tf
    ```
- AMI ID recomendada para arquitectura arm64
```bash
aws ssm get-parameter \
  --name /aws/service/ecs/optimized-ami/amazon-linux-2023/arm64/recommended/image_id \
  --query "Parameter.Value" \
  --region us-west-2 \
  --profile tf
```
- AMI ID recomendada para arquitectura GPU
    ```bash
    aws ssm get-parameter \
        --name /aws/service/ecs/optimized-ami/amazon-linux-2023/gpu/recommended/image_id \
        --query "Parameter.Value" \
        --output text \
        --region us-west-2 \
        --profile tf
    ```

---

## 📚 Referencias
- [Retrieving Amazon ECS-optimized Linux AMI metadata](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/retrieve-ecs-optimized_AMI.html)
- [Calling AMI public parameters in Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-public-parameters-ami.html)
- [Reference the latest AMIs using Systems Manager public parameters](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami-parameter-store.html)
- [Resource: aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)
- [Receive notifications on new updates](https://docs.aws.amazon.com/linux/al2023/ug/receive-update-notification.html)

---