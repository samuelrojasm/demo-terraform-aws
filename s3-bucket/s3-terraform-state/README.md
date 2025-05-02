## 🛠️ Demo: Amazon S3 - Bucket para guardar estado de Terraform

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Establecer de forma segura y reutilizable el almacenamiento del estado remoto de Terraform en AWS, como paso previo a cualquier proyecto de infraestructura que dependa de este backend.

## 🧱 Recursos creados
- Crear la infraestructura inicial necesaria para almacenar el estado remoto (backend) de Terraform en AWS, incluyendo:
    - Un bucket S3 con versionado y cifrado activados (almacenar el archivo **`terraform.tfstate`**.)

## 🚀 Resultado (Outcome)
### Terraform apply
- El output incluirá el nombre del **storage_account** y del **container**, necesarios para configurar el backend remoto en otros proyectos.
<p align="center">
<img src="assets/imagenes/blob_outputs.png" alt="Terraform apply" width="60%">
</p>