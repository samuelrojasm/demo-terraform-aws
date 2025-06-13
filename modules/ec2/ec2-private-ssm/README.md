## 🛠️ Terraform - Módulo - Crea EC2 privada con acceso por SSM

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
-  Este módulo de Terraform crea un entorno **EC2** configurado en una subnet privada, idealmente en la misma red que un clúster de EKS privado u otros recursos internos.
- Se utiliza por un módulo superior que tiene como objetivo crear la EC2 + VPC EndPoint, esto se diseña de esta manera con la finalidad de evitar referencias cruzadas al momento de asignar las reglas de los SGs de EC2 y VPC EndPoint
- Deja lista la EC2 para incluir automáticamente los VPC endpoints necesarios.

---

## ⚙️ Recursos creados
- Una EC2
- Rol SSM asignado a la EC2
    - Acceso a la EC2 solo vía SSM (sin NAT, sin IGW)
- Security Group asignado a la EC2
    - Solo se crea no incluye reglas (no se adicionan para evitar referencias cruzadas al conectar con el VPC Endpoint)

---

## ✔️ Requisitos
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
| `ami_id`                     | string       |-               |

---

## 🧪 Ejemplo de uso (main.tf del root project)
- Llamada al módulo
    ```hcl
    module "ec2-private-ssm" {
        source    = "./modules/ec2/ec2-private-ssm"

        vpc_id    = "vpc-12345678"
        subnet_id =  ["subnet-aaaa"]
        ami_id    = module.latest_al2023_x86_64_ami.ami_id

        tags = {
            Environment = "lab"
            Project     = "eks-private-cluster"
        }
    }
    ```

---

## 📚 Referencias
- [Resource: aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)
- [Resource: aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
- [Resource: aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Terraform templatefile Function](https://developer.hashicorp.com/terraform/language/functions/templatefile)


---