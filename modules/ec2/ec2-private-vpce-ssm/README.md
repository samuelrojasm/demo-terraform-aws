## 🛠️ Terraform - Módulo - Crea EC2 + VPC Endpoints Privados para SSM para acceder a EC2
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo
- Agrupar EC2 + VPC Endpoint en un solo módulo

--

## 🧱 Recursos creados
- SG para EC2
- SG para VPCE
- EC2 con IAM y SSM Agent
- VPCEs de SSM (ssm, ssmmessages, ec2messages)
- Asociar SGs entre ellos con **rules** del submódulo oficial

---

## 🔧 Argumentos del módulo
- Lista de argumentos para el sub-módulo: **`ec2-private-ssm`**
| Nombre                       | Tipo         | Valor Default  |
|------------------------------|--------------|----------------|          
| `subnet_id`                  | string       | -              |             
| `instance_type`              | string       |t3.micro        |
| `ami`                        | string       |-               |


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