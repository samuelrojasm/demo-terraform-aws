## 🛠️ Terraform - Módulo - AMI de bottlerocket optimizada para Amazon EKS y ECS

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Obtener el ID de la AMI de Bottlerocket
- Usa **latest** en la ruta para asegurar de que siempre obtengamos la última versión de la AMI disponible para esa combinación de orquestador/arquitectura/variante. 

---

## 🔧 Variables del módulo

| Nombre                    | Tipo   | Valor Default | Possible settings |
|---------------------------|------- |---------------|-------------------|                  
| `orchestrator`            | string | -             | eks, ecs          |
| `architecture`            | string | x86_64        | x86_64, arm64    |
| `kubernetes_version`      | string | Null          | -                 |
| `gpu_support`             | bool   | false         | true, false       |
| `fips_support`            | bool   | false         | true,false        |
| `bottlerocket_variant_map`| map    | base_prefix = "/aws/service/bottlerocket" <br> eks_prefix  = "aws-k8s" <br> ecs_prefix  = "aws-ecs-2" # La más común/reciente <br> gpu_suffix  = "-nvidia" <br> fips_suffix = "-fips  | -  |

---

## 🧪 Ejemplo de uso (main.tf del root project)
### --- Ejemplo para EKS con ARM64 y GPU ---
```hcl
module "bottlerocket_ami_eks_arm64_gpu" {
  source = "./modules/bottlerocket_ami" # Ruta del módulo

  orchestrator       = "eks"
  architecture       = "arm64"
  kubernetes_version = "1.29" # Asegúrate de que esta versión de K8s exista en AWS
  gpu_support        = true
  fips_support       = false # Por defecto, puedes omitirlo
}

output "ami_id_eks_arm64_gpu" {
  value = module.bottlerocket_ami_eks_arm64_gpu.ami_id
}

output "ssm_path_eks_arm64_gpu" {
  value = module.bottlerocket_ami_eks_arm64_gpu.ssm_parameter_path
}
```
### --- Ejemplo para ECS con X86_64 y sin GPU/FIPS ---
```hcl
module "bottlerocket_ami_ecs_x86_64" {
  source = "./modules/bottlerocket_ami"

  orchestrator = "ecs"
  architecture = "x86_64"
  # gpu_support y fips_support se usarán con sus valores por defecto (false)
}

output "ami_id_ecs_x86_64" {
  value = module.bottlerocket_ami_ecs_x86_64.ami_id
}

output "ssm_path_ecs_x86_64" {
  value = module.bottlerocket_ami_ecs_x86_64.ssm_parameter_path
}
```

---

## Probar módulo local
- Desde el directorio raíz del proyecto Terraform
```bash
terraform plan -var="orchestrator=eks" -var="kubernetes_version=1.29"
terraform plan -var="orchestrator=eks" -var="kubernetes_version=1.29" -var="architecture=arm64"
terraform plan -var="orchestrator=eks" -var="kubernetes_version=1.33" -var="fips_support=true"
terraform plan -var="orchestrator=eks" -var="kubernetes_version=1.33" -var="gpu_support=true"
```
```bash
terraform plan -var="orchestrator=ecs"
terraform plan -var="orchestrator=ecs" -var="fips_support=true"
terraform plan -var="orchestrator=ecs" -var="gpu_support=true"
```
- Usando archivo .tfvars
```bash
terraform plan -var-file="test.tfvars"
```

## 📌 Llamada a parámetros públicos de AMI en Parameter Store
### 1.- Primer paso investigar la estructura de las jerarquía de los Parámetros
#### Ejempo Bottlerocket – para EKS
- Listado de AMIs de Bottlerocket versión específica de K8
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/bottlerocket/aws-k8s-1.30 \
        --recursive \
        --max-items 500 \
        --query "Parameters[?contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```
- Búsqueda de AMIs Bottlerocket para una versión específica de K8
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/bottlerocket \
        --recursive \
        --query "Parameters[?contains(Name, 'aws-k8s-1.30') && contains(Name, 'x86_64') && contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```
#### Ejempo Bottlerocket – para ECS
- Búsqueda de AMIs Bottlerocket para ECS
- Posibles categorías: aws-ecs-1, aws-k8s-X.YY, aws-dev
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/bottlerocket/aws-ecs-2 \
        --recursive \
        --query "Parameters[?contains(Name, 'x86_64') && contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```
- Búsqueda de AMIs Bottlerocket para ECS con condicones específicas
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/bottlerocket/aws-k8s-1.30 \
        --recursive \
        --query "Parameters[?contains(Name, 'x86_64') && contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```
#### Ejempo de bottlerocket – AMIs optimizadas
- Explorar los Parameter Store de bottlerocket
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/bottlerocket \
        --recursive \
        --query "Parameters[?contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```

###  2.- Segundo paso obtener el ID del AMI
#### Ejempo Bottlerocket AMI ID para K8
- Obtiene el AMI ID de Bottlerocket para K8
    ```bash 
    aws ssm get-parameter \
        --name /aws/service/bottlerocket/aws-k8s-1.30/x86_64/latest/image_id \
        --query "Parameter.Value" \
        --output text \
        --region us-west-2 \
        --profile tf
    ```
#### Ejempo Bottlerocket AMI ID para ECS
- Obtiene el AMI ID de Bottlerocket para ECS
    ```bash 
    aws ssm get-parameter \
        --name /aws/service/bottlerocket/aws-ecs-2/x86_64/latest/image_id \
        --query "Parameter.Value" \
        --output text \
        --region us-west-2 \
        --profile tf
    ```

---

## Ejemplos de rutas de Parameter Store
### Bottlerocket K8 - Arquitectura
```bash 
/aws/service/bottlerocket/aws-k8s-1.30/arm64/latest/image_id
/aws/service/bottlerocket/aws-k8s-1.30/x86_64/latest/image_id
```
### Bottlerocket K8 - GPU
- Diponible a partir de la versión 1.21 (aws-k8s-1.21-nvidia)
```bash 
/aws/service/bottlerocket/aws-k8s-1.21-nvidia/x86_64/latest/image_id
/aws/service/bottlerocket/aws-k8s-1.23-nvidia/arm64/latest/image_id
```
### Bottlerocket K8 - FIPS
- Diponible a partir de la versión 1.28 (aws-k8s-1.28-fips)
```bash 
/aws/service/bottlerocket/aws-k8s-1.32-fips/x86_64/latest/image_id
/aws/service/bottlerocket/aws-k8s-1.33-fips/arm64/latest/image_id
```
### Bottlerocket ECS - Arquitectura
```bash 
/aws/service/bottlerocket/aws-ecs-2/arm64/latest/image_id
/aws/service/bottlerocket/aws-ecs-2/x86_64/latest/image_id
```
### Bottlerocket ECS - GPU
```bash 
/aws/service/bottlerocket/aws-ecs-2-nvidia/arm64/latest/image_id
/aws/service/bottlerocket/aws-ecs-2-nvidia/x86_64/latest/image_id
```
### Bottlerocket ECS - FIPS
```bash 
/aws/service/bottlerocket/aws-ecs-2-fips/x86_64/latest/image_id
/aws/service/bottlerocket/aws-ecs-2-fips/arm64/latest/image_id
```
### Versiones específicas de Bottlerocket
```bash 
/aws/service/bottlerocket/aws-ecs-2-fips/x86_64/1.40.0/image_id
/aws/service/bottlerocket/aws-k8s-1.30/x86_64/1.20.4/image_id
```

 ---
 
## 📚 Referencias
- [Calling AMI public parameters in Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-public-parameters-ami.html)
- [Reference the latest AMIs using Systems Manager public parameters](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami-parameter-store.html)
- [Resource: aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)
- [Receive notifications on new updates](https://docs.aws.amazon.com/linux/al2023/ug/receive-update-notification.html)
- [Bottlerocket](https://aws.amazon.com/bottlerocket)
- [Bottlerocket Documentation](https://bottlerocket.dev/en/)
- [GitHub-Bottlerocket OS](https://github.com/bottlerocket-os/bottlerocket)

---