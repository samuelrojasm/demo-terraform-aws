#--------------------------
# vpc-endpoints-ssm
#--------------------------

# Variables locales
locals {
  base_services = [
    "ssm",
    "ec2messages",
    "ssmmessages",
  ]

  optional_services = concat(
    var.include_logs_endpoint ? ["logs"] : [],
    var.include_kms_endpoint  ? ["kms"]  : []
  )

  all_services = concat(local.base_services, local.optional_services)
}

# Definición de VPC Endpoints
resource "aws_vpc_endpoint" "ssm_endpoints" {
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

# Security Group para los Endpoints
resource "aws_security_group" "this" {
  name        = "ssm-endpoints-sg"
  description = "Allow HTTPS for VPC endpoints"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

