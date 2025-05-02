## 🛠️ Demo: VPC (Virtual Private Cloud) con Internet Gateway

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
Este ejemplo provisiona una VPC con los siguientes componentes:
- 1 **`Internet Gateway`**
- 3 **`Public Subnets`**, una en cada AZ
- 3 **`Private Subnets`**, una en cada AZ
- Configuración de **`Route Table`** (principal y adicional)

---

## 🚀 Resultado (Outcome)
### Terraform apply
![Private Subnet](assets/imagenes/terraform_apply.png)
### Resource map (Public Subnets)
![Public Subnet](assets/imagenes/public_subnets.png)
### Resource map (Private Subnets)
![Private Subnet](assets/imagenes/private_subnets.png)

---