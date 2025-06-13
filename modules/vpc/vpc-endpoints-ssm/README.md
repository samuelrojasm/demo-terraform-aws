## 🛠️ Terraform - Módulo - Crea VPC Endpoints Privados para SSM para acceder a EC2

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Este módulo de Terraform tiene como objetivo provisionar los **VPC Endpoints privados** necesarios para habilitar el acceso a instancias EC2 mediante AWS Systems Manager (SSM) en redes privadas, sin requerir conexión a Internet ni NAT Gateway.
- Permitir que una EC2 100% privada (sin NAT, sin IGW) sin acceso a Internet pueda usar AWS SSM mediante Interface Endpoints (basados en AWS PrivateLink).

---

## ✔️ Requisitos
- Requisitos para acceder a EC2 privada con SSM sin NAT 
    - AWS SSM requiere los siguientes VPC Interface Endpoints:

| Servicio                     | Tipo de endpoint |Nombre del Endpoint AWS|
| ---------------------------- | ---------------- | ------------------------ |
| `ssm`                        | Interface        |`com.amazonaws.<region>.ssm`|
| `ssmmessages`                | Interface        |`com.amazonaws.<region>.ssmmessages`|
| `ec2messages`                | Interface        |`com.amazonaws.<region>.ec2messages`|
| `kms` (opcional si usas KMS) | Interface        |`com.amazonaws.<region>.kms`|
| `Logs`(opcional si usas CloudWatch) | Interface |`com.amazonaws.<region>.logs`|

---

## 📌 Notas
- Los endpoints deben estar en subnets privadas.
- Private DNS habilitado `(private_dns_enabled = true)` hace que las instancias puedan usar `ssm.<region>.amazonaws.com` directamente.
- La seguridad de acceso a los endpoints se gestiona con el `Security Group`.
- `kms` y `logs` se manejan como endpoints opcionales controlados con flags.

---

## 🔧 Argumentos del módulo
- Lista de argumentos

| Nombre                       | Tipo         | Valor Default  |
|------------------------------|--------------|----------------|
| `vpc_id`                     | string       | -              |               
| `subnet_ids`                 | list(string) | -              |             
| `region`                     | string       | -              |
| `include_logs_endpoint`      | bool         |false           |
| `include_kms_endpoint`       | bool         |false           |
| `tags`                       | map(string)  |{ }             |
    
---

## 🧪 Ejemplo de uso (main.tf del root project)
- Llamada al módulo
    ```hcl
    module "ssm_vpc_endpoints" {
        source               = "./modules/vpc/vpc-endpoints-ssm"

        vpc_id               = "vpc-12345678"
        subnet_ids           = ["subnet-aaaa", "subnet-bbbb"]
        region               = "us-east-1"
        include_logs_endpoint = true
        include_kms_endpoint  = true

        tags = {
            Environment = "lab"
            Project     = "eks-private-cluster"
        }
    }
    ```

---

## 📚 Referencias

- [Improve the security of EC2 instances by using VPC endpoints for Systems Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html)
- [How do I create Amazon VPC endpoints so that I can use Systems Manager](https://repost.aws/knowledge-center/ec2-systems-manager-vpc-endpoints)
- [VPC Endpoints centralizados](https://www.paradigmadigital.com/dev/vpc-endpoints-centralizados-que-son)
- [Security group rules](https://docs.aws.amazon.com/vpc/latest/userguide/security-group-rules.html)

---