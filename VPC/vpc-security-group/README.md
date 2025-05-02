## 🛠️ Demo: VPC (Virtual Private Cloud) con Security Groups

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Este ejemplo provisiona una VPC con los siguientes componentes:
    - 2 **`Security Groups`**
    - Uno de los security groups aplica control de acceso basado en la referencia de un SG en lugar de direcciones IP estáticas.

---

## 🚀 Resultado (Outcome)
### Terraform apply
![Private Subnet](assets/imagenes/terraform_apply.png)
### security_group_web (Inbound rules)
![Private Subnet](assets/imagenes/sg_web_in.png)
### security_group_database (Inbound rules)
![Private Subnet](assets/imagenes/sg_db_in.png)
### Outbound rule
![Private Subnet](assets/imagenes/sg_outbound.png)

---