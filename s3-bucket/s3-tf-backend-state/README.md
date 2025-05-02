## 🛠️ Demo: Amazon S3 - Almacenar estado de Terraform en un Bucket

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Demostrar cómo almacenar el estado de Terraform de forma remota utilizando un bucket de Amazon S3, haciendo uso del bloque **`backend`** en la configuración de Terraform. 
- Almacena el archivo de estado en un servicio remoto en Amazon S3, lo que garantiza un acceso centralizado y una mejor colaboración.
- Adoptar un backend remoto como Amazon S3 es un paso crucial para construir una infraestructura resiliente y escalable con Terraform.
- Esta práctica permite una mejor gestión del estado en entornos colaborativos y asegura la persistencia y consistencia del estado de la infraestructura.

---

## 💡 Motivo
- Terraform almacena por defecto el estado de la infraestructura en un archivo local (`terraform.tfstate`). Esto puede ser problemático cuando múltiples personas trabajan en el mismo proyecto o cuando se desea centralizar y asegurar este archivo. Utilizar un backend remoto como Amazon S3:
    - Previene conflictos en el archivo de estado.
    - Facilita el trabajo en equipo.
    - Permite versionado, auditoría y recuperación ante fallos.
    - Es un paso inicial hacia la automatización y el control de cambios en infraestructura como código.

---

## ✅ Prerequisitos
- Para usar la función de **backend state** es necesario tener listo los siguientes recursos:
    - Bucket de Amazon S3 para almacenar el estado de Terraform

---

## 🚀 Resultado (Outcome)
### Terraform apply
- El output incluirá el nombre del **S3 Bucket** para configurar el backend remoto en otros proyectos.
<p align="center">
<img src="assets/imagenes/s3_tf_state_apply.png" alt="Terraform apply" width="80%">
</p>

### Terraform state list
<p align="center">
<img src="assets/imagenes/s3_tf_state_resource_list.png" alt="Terraform State" width="80%">
</p>

### Lista el Bucket creado en S3 con AWS CLI
 <p align="center">
    <img src="assets/imagenes/s3_tf_state_list_bucket.png" alt="Lista Bucket" width="70%">
    </p>

### Lista Bucket en la consola 
 <p align="center">
    <img src="assets/imagenes/s3_tf_state_console_bucket.png" alt="Container" width="90%">
    </p>

---

## 📚 Referencias
- [Stores the state as a given key in a given bucket on Amazon S3](https://developer.hashicorp.com/terraform/language/backend/s3)
- []()
- []()
- []()

---