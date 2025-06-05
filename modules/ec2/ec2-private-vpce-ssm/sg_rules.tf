#---------------------------------------------------
# Reglas entre Security Groups
# Define las reglas de referencia cruzada SG ↔ SG
#---------------------------------------------------

module "sg_rules_vpce" {
  source  = "terraform-aws-modules/security-group/aws//modules/rules"
  version = "~> 5.1"

security_group_id = module.vpce_ssm.sg_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      source_security_group_id = module.ec2_ssm.sg_id
      description              = "Allow EC2 to connect to VPCE"
    }
  ]
}

module "sg_rules_ec2_egress" {
  source  = "terraform-aws-modules/security-group/aws//modules/rules"
  version = "~> 5.1"

  security_group_id = module.ec2_ssm.sg_id

  egress_with_source_security_group_id = [
    {
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      source_security_group_id = module.vpce_ssm.sg_id
      description              = "Allow EC2 egress to VPCE"
    }
  ]
}