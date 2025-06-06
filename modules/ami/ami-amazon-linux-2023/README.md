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
