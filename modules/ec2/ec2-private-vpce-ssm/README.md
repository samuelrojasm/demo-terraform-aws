


## Objetivo
- Agrupar EC2 + VPC Endpoint en un solo módulo

## Crea
- SG para EC2
- SG para VPCE
- EC2 con IAM y SSM Agent
- VPCEs de SSM (ssm, ssmmessages, ec2messages)
- Asociar SGs entre ellos con **rules** del submódulo oficial