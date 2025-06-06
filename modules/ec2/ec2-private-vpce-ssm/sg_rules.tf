#---------------------------------------------------
# Reglas entre Security Groups
# Define las reglas de referencia cruzada SG ↔ SG
#---------------------------------------------------

# Uso del módulo oficial para crear regla ingress en VPCE SG que permita tráfico desde EC2 SG
module "sg_rules_vpce" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.3"

  create_sg         = false
  security_group_id = module.vpce_ssm.sg_id
  ingress_with_source_security_group_id = [
    {
      description              = "Allow EC2 to connect to VPCE on HTTPS"
      rule                     = "https-443-tcp"
      source_security_group_id = module.ec2_ssm.sg_id
    }
  ]
  # Egresos no son estrictamente necesarios, pero puedes permitir AWS SSM backends
  egress_rules = ["https-443"]
}

# Uso del módulo oficial para crear regla egress en EC2 SG que permita salir hacia VPCE SG
module "sg_rules_ec2_egress" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.3"

  create_sg         = false
  security_group_id = module.ec2_ssm.sg_id
  egress_with_source_security_group_id = [
    {
      description              = "Allow EC2 egress to VPCE on HTTPS"
      rule                     = "https-443-tcp"
      source_security_group_id = module.vpce_ssm.sg_id
    }
  ]
  # Ingresos no necesarios si solo usas SSM (no SSH, no puertos expuestos)
  ingress_rules = []
}