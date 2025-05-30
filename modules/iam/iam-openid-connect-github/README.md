# 🛠️ Terraform - Bootstrap - Crea Proveedor de identidad OIDC de GitHub
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)


## 🔍 Detalles importantes
- AWS no permite múltiples instancias del mismo **oidc-provider** por cuenta.
- El proveedor de OIDC de GitHub es global y compartido: https://token.actions.githubusercontent.com
- Lo recomendable es que ese proveedor se cree fuera de otros módulos de Terraform, una vez, como parte de la infraestructura base (bootstrap).