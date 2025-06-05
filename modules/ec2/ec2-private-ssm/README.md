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

## 🧪 Ventajas:
- Acceso seguro al clúster EKS privado, vía túneles SSM
- Automatización con Terraform, reutilizando el módulo en diferentes proyectos o laboratorios
- Estandarización del entorno de desarrollo, con control sobre tags y tipo de instancia
- Integración con otros módulos de red, EKS, IAM o bastiones

---

## 🧱 Recursos creados
- Crea VPC y subnets privadas
- Lanza una EC2 con rol SSM
- Llama al submódulo vpc-endpoints-ssm

---

## 🚀 Resultado (Outcome)
### Terraform output
<p align="center">
    <img src="../../assets/imagenes/terraform_console_output.png" alt="Terraform Console" width="80%">
</p>

### Terraform output
<p align="center">
    <img src="../../assets/imagenes/terraform_console_output.png" alt="Terraform Console" width="80%">
</p>

---


- [Terraform module to create AWS VPC resources](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)

