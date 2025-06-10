## 🛠️ Terraform - Módulo - AMI de bottlerocket optimizada para Amazon EKS,EC2 y EC

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)


---

## 🔧 Variables del módulo

| Nombre                | Tipo         | Valor Default         | Possible settings |
|-----------------------|--------------|-----------------------|-------------------|                  
| `orchestrator`        | string       | -                  | eks, ecs, ec2  |
| `architecture`        | string       | x86_64                |  x86_64, arm64  |
| `kubernetes_version`  | string       |                       | -   |
| `gpu_support`         | bool      | false                     | true, false  |
| `fips_support`         | bool      | false                      | true,false  |
| `bottlerocket_variant_map`         | map      | base_prefix = "/aws/service/bottlerocket" <br> eks_prefix  = "aws-k8s" <br> ecs_prefix  = "aws-ecs-2" # La más común/reciente <br> ec2_prefix  = "aws-dev" # Variante genérica para EC2 <br> gpu_suffix  = "-nvidia" <br> fips_suffix = "-fips  | -  |


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

---

## 📌 Llamada a parámetros públicos de AMI en Parameter Store
### 1.- Primer paso investigar la estructura de las jerarquía de los Parámtros
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
 
## 📚 Referencias
- [Calling AMI public parameters in Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-public-parameters-ami.html)
- [Reference the latest AMIs using Systems Manager public parameters](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami-parameter-store.html)
- [Resource: aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)
- [Receive notifications on new updates](https://docs.aws.amazon.com/linux/al2023/ug/receive-update-notification.html)

---