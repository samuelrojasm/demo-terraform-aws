


## Objetivo
- Agrupar EC2 + VPC Endpoint en un solo módulo

## Crea
- SG para EC2
- SG para VPCE
- EC2 con IAM y SSM Agent
- VPCEs de SSM (ssm, ssmmessages, ec2messages)
- Asociar SGs entre ellos con **rules** del submódulo oficial



## Referencias
- [AWS EC2-VPC Security Group Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest)
- [Examples rules-only](https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/examples/rules-only/main.tf)