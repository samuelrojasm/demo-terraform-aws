## 🛠️ Terraform - Módulo - Busca AMI de Amazon Linux 2023

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Para usar **Amazon Linux 2023 (AL2023)** en Terraform, lo recomendable es obtener la AMI de forma dinámica usando el data source aws_ami, ya que los IDs cambian según la región y el tiempo.
- Obtener dinámicamente la última **AMI de Amazon Linux 2023**, con soporte para arquitectura (x86_64 o arm64) y región.

---

## Notas
- 137112412989 es el owner ID oficial de Amazon Linux.
- Puedes cambiar "x86_64" por "arm64" si usas instancias Graviton.
- Este método es multi-región.

---

## 🔧 Variables del módulo

| Nombre                | Tipo         | Valor Default         |
|-----------------------|--------------|-----------------------|
| `architecture`        | string       | x86_64                |
| `owner`               | string       | 137112412989          |
| `name_prefix`         | string       | al2023-ami-*-*"       |

---

## 🧪 Ejemplo de uso (main.tf del root project)
- Llamada al módulo y uso del resultado
    ```hcl
    module "al2023" {
        source      = "./modules/amazon-linux-2023"
        architecture = "x86_64"
    }

    resource "aws_instance" "this" {
        ami                    = module.al2023.ami_id
        instance_type          = "t3.micro"
        subnet_id              = var.subnet_id
        vpc_security_group_ids = [aws_security_group.this.id]

        iam_instance_profile        = aws_iam_instance_profile.this.name
        associate_public_ip_address     = false

        tags = {
            Name = "ec2-amazon-linux-2023"
        }
    }
    ```
---

## 📌 Llamada a parámetros públicos de AMI en Parameter Store
### 1.- Primer paso investigar la estructura de las jerarquía de los Parámtros
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
        --profile tf \
    ```
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
#### Ejempo de bottlerocket para ECS – AMIs optimizadas
    ```bash
    aws ssm get-parameters-by-path \
        --path /aws/service/bottlerocket \
        --recursive \
        --query "Parameters[?contains(Name, 'image_id')].[Name]" \
        --region us-west-2 \
        --profile tf
    ```

###  2.- Segundo paso obtener el ID del AMI
#### Ejempo AWS EKS AMI ID
- Patrón de nombre de Parameter store
    ``bash 
    /aws/service/eks/optimized-ami/<kubernetes-version>/<ami-type>/recommended/image_id
    ```
- AMI ID de versión específica
     ``bash 
    aws ssm get-parameter \
        --name /aws/service/eks/optimized-ami/1.29/amazon-linux-2023/x86_64/standard/recommended/image_id \
        --query "Parameter.Value" \
        --output text \
        --region us-west-2 \
        --profile tf
    ```
#### Ejempo Amazon Linux AMI ID
    ```bash 
    aws ssm get-parameter \
        --name /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64 \
        --query "Parameter.Value" \
        --output text \
        --region us-west-2 \
        --profile tf
    ```

aws ssm get-parameters-by-path \
         --path /aws/service/ami-amazon-linux-2023-latest/arm64 \
        --recursive \
        --region us-west-2 \
        --profile tf



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
#### Ejempo Bottlerocket AMI ID para K8
    ```bash 
    aws ssm get-parameter \
        --name /aws/service/bottlerocket/aws-k8s-1.30/x86_64/latest/image_id \
        --query "Parameter.Value" \
        --output text \
        --region us-west-2 \
        --profile tf
    ```
#### Ejempo Bottlerocket AMI ID para ECS
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
- []()
- []()
- []()
- []()
- []()

---


 aws ssm get-parameters-by-path \
        --path /aws/service/eks/optimized-ami/1.29  \
        --recursive \
        --query "Parameters[?contains(Name, 'image_id')].[Name]" \
        --region us-east-1 \
        --profile tf