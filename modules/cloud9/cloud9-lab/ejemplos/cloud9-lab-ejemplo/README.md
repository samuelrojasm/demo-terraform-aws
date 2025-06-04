## 🛠️ Ejemplo de uso de módulo Cloud9

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- El objetivo principal es proporcionar una forma **segura, reproducible y automatizada** de desplegar un entorno de desarrollo en AWS  Cloud9  ubicado en la misma VPC y subnet privada, que facilite la administración de recursos en redes privadas (como EKS sin endpoint público), sin necesidad de:
    - Crear o gestionar llaves SSH
    - Exponer puertos en la red
    - Lanzar EC2 manualmente
- Este módulo de Terraform crea un entorno **AWS Cloud9** EC2 configurado en una subnet privada, idealmente en la misma red que un clúster de EKS privado u otros recursos internos.
- Este entorno sirve como bastión seguro o punto de entrada para administrar recursos en redes privadas (como EKS privados), sin necesidad de abrir puertos ni usar claves SSH.

## 🧪 Ventajas:
- Acceso seguro al clúster EKS privado, desde la consola Cloud9 o vía túneles SSM
- Automatización con Terraform, reutilizando el módulo en diferentes proyectos o laboratorios
- Estandarización del entorno de desarrollo, con control sobre tags, tipo de instancia y políticas de autoapagado
- Integración con otros módulos de red, EKS, IAM o bastiones

---

## 🧱 Recursos creados
- AWS VPC
- AWS Cloud9 EC2 

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


El objetivo principal es proporcionar una forma **segura, reproducible y automatizada** 
de desplegar un entorno de desarrollo en AWS que facilite la administración de 
recursos en redes privadas (como EKS sin endpoint público), sin necesidad de:

- Crear o gestionar llaves SSH
- Exponer puertos en la red
- Lanzar EC2 manualmente
