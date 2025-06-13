output "sg_rules_vpce_rule_description" {
  value = "EC2 puede acceder a VPCE por HTTPS (443)"
}

output "sg_rules_ec2_egress_rule_description" {
  value = "EC2 tiene salida permitida hacia VPCE por HTTPS (443)"
}

output "aws_instance_info" {
  value = module.ec2_ssm.aws_instance_info
}