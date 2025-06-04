## 🛠️ Terraform - Módulo - Crea una instancia AWS Cloud9

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white)](#)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](#)
[![HCL](https://img.shields.io/badge/Language-HCL-blueviolet)](#)

## 🎯 Objetivo (Target)



---

## 🔧 Argumentos del módulo

| Nombre                       | Tipo         | Descripción                                       | Valor Default     |
|------------------------------|--------------|---------------------------------------------------|-------------------|
| `name`                       | string       | The name of the environment                       | N/A               |
| `description`                | string       | The description of the environment                | Cloud9 environment for labs               |
| `instance_type`              | string       | The type of instance to connect to the environment|t3.small           |
| `subnet_id`                  | string       | The ID of the subnet in Amazon VPC that AWS Cloud9 will use to communicate with the Amazon EC2 instance | N/A|
| `automatic_stop_time_minutes`| number       | The number of minutes until the running instance is shut down after the environment has last been used. | 60|
| `image_id`                   | string       | The identifier for the Amazon Machine Image (AMI) that's used to create the EC2 instance |amazonlinux-2023-x86_64|
| `connection_type`            | string       | The connection type used for connecting to an Amazon EC2 environment                     | CONNECT_SSM|
| `tags`                       | map(string)  | Key-value map of resource tags | {} |

---

## 🧪 Ejemplo de uso (main.tf del root project)
- Llamada al módulo
    ```hcl
    module "cloud9_lab" {
        source  = "./modules/cloud9-lab"
        name                        = "cloud9-eks-lab"
        description                 = "Instancia para administrar EKS"
        instance_type               = "t3.small"
        subnet_id                   = "subnet-0abc123456789def0"
        tags = {
            Environment = "lab"
            Owner       = "cloud-team"
        }
    }
    ```

---

## 📚 Referencias

- [aws_cloud9_environment_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloud9_environment_ec2)

---