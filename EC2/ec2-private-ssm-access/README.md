## 🛠️ Terraform - Crea EC2 + VPC Endpoints Privados para SSM para acceder a EC2
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo
- Este entorno de Terraform tiene como objetivo provisionar la infraestructura base necesaria (VPC + Subnet privada) y utilizar el módulo **ec2-private-vpce-ssm** para crear una instancia EC2 privada accesible mediante AWS Systems Manager (SSM), junto con los VPC Endpoints requeridos.
- Entorno de prueba mínimo, útil para validar el funcionamiento del acceso vía SSM a instancias en redes privadas, sin acceso a Internet.
- Este entorno sirve como bastión seguro o punto de entrada para administrar recursos en redes privadas (como EKS privados), sin necesidad de abrir puertos ni usar claves SSH.

--- 

## ⚙️ Recursos creados
- VPC
- Subnet privada
- Instancia EC2 privada:
    - Basada en Amazon Linux 2023
    - Con SSM Agent
- VPC Endpoints de tipo Interface necesarios para el funcionamiento completo de SSM
- Security Groups para permitir el tráfico entre la EC2 y los VPC Endpoints

---

## 🧩 Módulos usados
```bash
├── main.tf (módulo root)
│   │
│   ├── módulo: ec2-private-vpce-ssm
│   │  │ 
│   │  ├─ módulo: ec2-private-ssm
│   │  │    └── Crea la EC2 con SSM
│   │  │
│   │  ├── módulo: vpce-ssm
│   │  │    └── Crea los VPC Endpoints
```

---

## 📚 Referencias
- [Improve the security of EC2 instances by using VPC endpoints for Systems Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html)
- [How do I create Amazon VPC endpoints so that I can use Systems Manager](https://repost.aws/knowledge-center/ec2-systems-manager-vpc-endpoints)
- [VPC Endpoints centralizados](https://www.paradigmadigital.com/dev/vpc-endpoints-centralizados-que-son)
- [Improve the security of EC2 instances by using VPC endpoints for Systems Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html)


---