## 🛠️ Terraform - Módulo - Crea VPC Endpoints Privados para SSM para acceder a EC2

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)
- Permitir que una EC2 100% privada (sin NAT, sin IGW) sin acceso a Internet pueda usar AWS SSM mediante Interface Endpoints (basados en AWS PrivateLink).
- Requisitos para acceder a EC2 privada con SSM sin NAT 
    - AWS SSM requiere los siguientes VPC Interface Endpoints:

| Servicio                     | Tipo de endpoint |Nombre del Endpoint AWS|
| ---------------------------- | ---------------- | ------------------------ |
| `ssm`                        | Interface        |`com.amazonaws.<region>.ssm`|
| `ssmmessages`                | Interface        |`com.amazonaws.<region>.ssmmessages`|
| `ec2messages`                | Interface        |`com.amazonaws.<region>.ec2messages`|
| `kms` (opcional si usas KMS) | Interface        |`com.amazonaws.<region>.kms`|
| `(Opcional) Logs`              | Interface      |`com.amazonaws.<region>.logs` (si usas CloudWatch)|

---

## 🧪 Requisitos
- La EC2 debe tener rol IAM con estas políticas:
    ```bash
    AmazonSSMManagedInstanceCore
    ```
- El agente SSM debe estar instalado y corriendo.

---

📌 Notas
- Los endpoints deben estar en subnets privadas.
- Private DNS habilitado `(private_dns_enabled = true)` hace que las instancias puedan usar `ssm.<region>.amazonaws.com` directamente.
- La seguridad de acceso a los endpoints se gestiona con el `Security Group`.
- `kms` y `logs` se manejan como endpoints opcionales controlados con flags.

---

## 🔧 Argumentos del módulo

| Nombre                       | Tipo         | Valor Default  |
|------------------------------|--------------|----------------|
| `vpc_id`                     | string       | -              |               
| `subnet_ids`                 | list(string) | -              |             
| `region`                     | string       | -              |
| `allowed_cidr_blocks`        | list(string) | -              |
| `include_logs_endpoint`      | bool         |false           |
| `include_kms_endpoint`       | bool         |false           |
| `tags`                       | map(string)  |{ }             |

---

## 🧪 Ejemplo de uso (main.tf del root project)
- Llamada al módulo
    ```hcl
    module "ssm_vpc_endpoints" {
        source               = "./modules/ssm-vpc-endpoints"
        vpc_id               = "vpc-12345678"
        subnet_ids           = ["subnet-aaaa", "subnet-bbbb"]
        region               = "us-east-1"
        allowed_cidr_blocks  = ["10.0.0.0/16"]
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

---