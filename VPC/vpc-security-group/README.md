## 🛠️ Demo: VPC (Virtual Private Cloud) con Security Groups

## 🎯 Objetivo (Target)
Este ejemplo provisiona una VPC con los siguientes componentes:
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