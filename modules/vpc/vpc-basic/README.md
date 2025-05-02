## 🛠️ Terraform AWS VPC Module

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
Este módulo crea una VPC sencilla en AWS con:
- CIDR por defecto `10.0.0.0/16`
- 2 subnets públicas
- Zonas `us-east-1a` y `us-east-1b`
- Soporte DNS habilitado

---

## ⚡️ Uso rápido

```hcl
module "vpc" {
  source = "github.com/tu-org/terraform-vpc-module"
}
```

---

##  📄 Uso con archivo terraform.tfvars
- Es posible definir todas las variables en un archivo `terraform.tfvars` para personalizar sin modificar el código del módulo:

```hcl
# terraform.tfvars
name               = "custom-vpc"
vpc_cidr           = "10.1.0.0/16"
public_subnets     = ["10.1.1.0/24", "10.1.2.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
tags = {
  Environment = "dev"
  Owner       = "network-team"
}
```

- Terraform detectará este archivo automáticamente:

  ```bash
  terraform init
  terraform apply
  ```

- También se puede usar otro nombre para el archivo de variables:

```bash
terraform apply -var-file="custom-values.tfvars"
```

---

## 🚀 Outputs
- `vpc_id`: ID de la VPC
- `public_subnet_ids`: IDs de subnets públicas

##  🔧 Variables
- Es posible sobrescribir cualquier variable si es necesario. Consultar **`variables.tf`**

## ✅ Requisitos
- AWS provider configurado
- Terraform >= 1.0

---

## 📚 Referencias

- []()
- []()
- []()

---