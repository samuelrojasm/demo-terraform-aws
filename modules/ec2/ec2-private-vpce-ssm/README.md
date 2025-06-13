## 🛠️ Terraform - Módulo - Crea EC2 + VPC Endpoints Privados para SSM para acceder a EC2
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo
- Agrupar EC2 + VPC Endpoint en un solo módulo
- Provisionar una instancia EC2 privada junto con los VPC Endpoints necesarios para acceder a la EC2 mediante AWS Systems Manager (SSM), sin requerir acceso público ni llaves SSH.
- Está diseñado para entornos seguros donde se requiere administración remota de instancias privadas a través de SSM, utilizando endpoints de tipo Interface para los servicios de SSM, EC2 Messages y otros relacionados.
- Proporcionar una forma **segura, reproducible y automatizada** de desplegar EC2 privada, que permita facilitar la administración de recursos en redes privadas (como EKS sin endpoint público), sin necesidad de:
    - Crear o gestionar llaves SSH
    - Exponer puertos en la red
    - Lanzar EC2 manualmente
- Este entorno sirve como bastión seguro o punto de entrada para administrar recursos en redes privadas (como EKS privados), sin necesidad de abrir puertos ni usar claves SSH.

---

## 🚀 Ventajas:
- Acceso seguro al clúster EKS privado, vía túneles SSM
- Automatización con Terraform, reutilizando el módulo en diferentes proyectos o laboratorios
- Estandarización del entorno de desarrollo, con control sobre tags y tipo de instancia
- Integración con otros módulos de red, EKS, IAM o bastiones

---

## ⚙️ Recursos creados
- Una instancia EC2 privada:
    - Basada en Amazon Linux 2023
    - Con SSM Agent
    - Asociación automática de la instancia EC2 con un IAM Role compatible con SSM
- Los VPC Endpoints de tipo Interface necesarios para el funcionamiento completo de SSM:
    - ssm
    - ssmmessages
    - ec2messages
- Reglas de Security Group para permitir el tráfico entre la EC2 y los VPC Endpoints:
    - Asociar SGs entre ellos usando el módulo oficial Security Group

---

## 🧩 Módulos usados
```bash
├── main.tf (módulo root)
│   │
│   ├── módulo: ec2-private-ssm
│   │   └── Crea la EC2 con SSM
│   │
│   ├── módulo: vpce-ssm
│   │   └── Crea los VPC Endpoints
│   │
│   ├── módulo: security-group
│   │   └── Crea los SGs para EC2 y VPC Endpoints

```

---

## 🔧 Argumentos del módulo
- Lista de argumentos para el sub-módulo: **`ec2-private-ssm`**

| Nombre                       | Tipo         | Valor Default  |
|------------------------------|--------------|----------------|              
| `instance_type`              | string       |t3.micro        |
| `ami_id`                     | string       |-               |


- Lista de argumentos para el sub-módulo: **`vpc-endpoints-ssm`**

| Nombre                       | Tipo         | Valor Default  |
|------------------------------|--------------|----------------|   
| `subnet_ids`                 | list(string) | -              |             
| `region`                     | string       | -              |
| `include_logs_endpoint`      | bool         |false           |
| `include_kms_endpoint`       | bool         |false           |


- Lista de argumentos comunes entre módulos

| Nombre                       | Tipo         | Valor Default  |
|------------------------------|--------------|----------------|
| `vpc_id`                     | string       | -              |   
| `tags`                       | map(string)  |{ }             |


- Uso de Security Group Referencing
    - Restricción de acceso mediante **Security Group referencing**, permitiendo únicamente instancias asociadas al SG `sg-id-ec2`  comunicarse con los endpoints de SSM vía**SG-to-SG rules**.
    - Dinamismo: no necesitas especificar IPs ni CIDRs.
    - Seguridad: se basa en relaciones entre recursos, no en rangos abiertos.
    - Escalabilidad: si asocias más EC2 al SG, ya tienen acceso sin tocar reglas.
    - Solo las interfaces de red (ENIs) de las VPCs Endpoints que tienen el SG `sg-id-ec2` pueden iniciar conexiones entrantes a este recurso.

---

## 🧪 Ejemplo de uso (main.tf del root project)
- Llamada al módulo
```hcl
module "lab_ssm_ec2_private" {
    source = "module/ec2/ec2-private-vpce-ssm"

    region        = var.aws_region
    vpc_id        = module.vpc.vpc_id
    subnet_ids    = module.vpc.private_subnets
    ami_id        = module.latest_al2023_x86_64_ami.ami_id
    instance_type = "t3.micro"

    tags = {
        Project = "eks-lab"
        Env     = "dev"
    }
}
```

---

## 📚 Referencias
- [AWS EC2-VPC Security Group Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest)
- [Examples rules-only](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/examples/rules-only/main.tf)
- [Security group rules](https://docs.aws.amazon.com/vpc/latest/userguide/security-group-rules.html)
- [Improve the security of EC2 instances by using VPC endpoints for Systems Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html)
- [How do I create Amazon VPC endpoints so that I can use Systems Manager](https://repost.aws/knowledge-center/ec2-systems-manager-vpc-endpoints)
- [VPC Endpoints centralizados](https://www.paradigmadigital.com/dev/vpc-endpoints-centralizados-que-son)
- [Terraform templatefile Function](https://developer.hashicorp.com/terraform/language/functions/templatefile)

---