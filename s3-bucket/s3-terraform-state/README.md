## 🛠️ Demo: Amazon S3 - Bucket para guardar estado de Terraform

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Establecer de forma segura y reutilizable el almacenamiento del estado remoto de Terraform en AWS, como paso previo a cualquier proyecto de infraestructura que dependa de este backend.

## 🧱 Recursos creados
- Crear la infraestructura inicial necesaria para almacenar el estado remoto (backend) de Terraform en AWS, incluyendo:
    - Un bucket S3 (almacenar el archivo **`terraform.tfstate`**)
    - Habilita versionado
    - Habilita cifrado
    - Bloquea el uso de ACLs (BucketOwnerEnforced)

## 🚀 Resultado (Outcome)
### Terraform apply
- El output incluirá el nombre del **S3 Bucket** para configurar el backend remoto en otros proyectos.
<p align="center">
<img src="assets/imagenes/s3_tf_state_apply.png" alt="Terraform apply" width="60%">
</p>

### Terraform state list
<p align="center">
<img src="assets/imagenes/s3_tf_state_resource_list.png" alt="Terraform State" width="50%">
</p>

### Lista el Bucket creado en S3 con AWS CLI
 <p align="center">
    <img src="assets/imagenes/s3_tf_state_list_bucket.png" alt="Lista Bucket" width="70%">
    </p>

### Lista Bucket en la consola 
 <p align="center">
    <img src="assets/imagenes/s3_tf_state_console_bucket.png" alt="Container" width="70%">
    </p>

---

## 📚 Referencias
- [Resource: aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [Resource: aws_s3_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)
- [Resource: aws_s3_bucket_server_side_encryption_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration)
- [Resource: aws_s3_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)

---