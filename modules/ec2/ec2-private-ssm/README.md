## 🛠️ Terraform - Módulo - Crea EC2 privada con acceso por SSM

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- El objetivo principal es proporcionar una forma **segura, reproducible y automatizada** de desplegar EC2 privada, que facilite la administración de recursos en redes privadas (como EKS sin endpoint público), sin necesidad de:
    - Crear o gestionar llaves SSH
    - Exponer puertos en la red
    - Lanzar EC2 manualmente
- Este módulo de Terraform crea un entorno **EC2** configurado en una subnet privada, idealmente en la misma red que un clúster de EKS privado u otros recursos internos.
- Incluir automáticamente los VPC endpoints necesarios.
- Este entorno sirve como bastión seguro o punto de entrada para administrar recursos en redes privadas (como EKS privados), sin necesidad de abrir puertos ni usar claves SSH.

---

## 🧪 Ventajas:
- Acceso seguro al clúster EKS privado, vía túneles SSM
- Automatización con Terraform, reutilizando el módulo en diferentes proyectos o laboratorios
- Estandarización del entorno de desarrollo, con control sobre tags y tipo de instancia
- Integración con otros módulos de red, EKS, IAM o bastiones

---

## 🧱 Recursos creados
- VPC
- Subnets privadas
- Una EC2 con rol SSM
    - Acceso a la EC2 solo vía SSM (sin NAT, sin IGW)
- Llama al submódulo **vpc-endpoints-ssm**

---

## 🧪 Requisitos
- La EC2 debe tener rol IAM con estas políticas:
    ```bash
    AmazonSSMManagedInstanceCore
    ```
- El agente SSM debe estar instalado y corriendo.

---

## 🔧 Argumentos del módulo

| Nombre                       | Tipo         | Valor Default  |
|------------------------------|--------------|----------------|
| `vpc_id`                     | string       | -              |               
| `subnet_id`                  | string       | -              |             
| `instance_type`              | string       |t3.micro        |
| `ami`                        | string       |-               |
| `environment`                | string       |lab             |
| `project`                    | string       |demo            |

---

## 🧪 Ejemplo de uso (main.tf del root project)
- Llamada al módulo
    ```hcl
    module "ssm_vpc_endpoints" {
        source               = "./modules/ssm-vpc-endpoints"
        vpc_id               = "vpc-12345678"
        subnet_ids           = ["subnet-aaaa", "subnet-bbbb"]
        region               = "us-east-1"
        allowed_cidr_blocks  = ["10.0.0.0/16"]
        include_logs_endpoint = true
        include_kms_endpoint  = true

        tags = {
            Environment = "lab"
            Project     = "eks-private-cluster"
        }
    }
    ```
---

- [Terraform module to create AWS VPC resources](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)

---