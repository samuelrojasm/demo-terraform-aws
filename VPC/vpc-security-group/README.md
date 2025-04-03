## 🛠️ Demo: VPC (Virtual Private Cloud) con Security Groups

## 🎯 Objetivo (Target)
Este ejemplo provisiona una VPC con los siguientes componentes:
- 2 **`Security Groups`**
- Uno de los security groups aplica control de acceso basado en la referencia de un SG en lugar de direcciones IP estáticas.

---

## 🚀 Resultado (Outcome)
### Terraform apply
![Private Subnet](assets/imagenes/terraform_apply.png)
### Resource map (Public Subnets)
![Public Subnet](assets/imagenes/public_subnets.png)
### Resource map (Private Subnets)
![Private Subnet](assets/imagenes/private_subnets.png)

---