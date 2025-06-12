#--------------------------------------------------
#Variables locales
#--------------------------------------------------
locals {
  base_services = [
    "ssm",
    "ec2messages",
    "ssmmessages",
  ]

  optional_services = concat(
    var.include_logs_endpoint ? ["logs"] : [],
    var.include_kms_endpoint ? ["kms"] : []
  )

  all_services = concat(local.base_services, local.optional_services)
}

#--------------------------------------------------
# Creación del los VPC endpoints
#--------------------------------------------------
resource "aws_vpc_endpoint" "this" {
  for_each = toset(local.all_services)

  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.region}.${each.key}"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_ids
  security_group_ids = [aws_security_group.this.id]

  private_dns_enabled = true

  tags = merge(var.tags, {
    Name = "vpce-${each.key}"
  })
}

#--------------------------------------------------
# Security Group para los Endpoints
#--------------------------------------------------
resource "aws_security_group" "this" {
  name        = "sg-ssm-endpoints"
  vpc_id      = var.vpc_id
  description = "Allow HTTPS ingress for VPC endpoints"

  tags = merge(var.tags, {
    Name = "sg-ssm-endpoints"
  })
}