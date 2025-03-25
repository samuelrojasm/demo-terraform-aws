# Definición de VPC y Subred

# Generar nombres dinámicos
locals {
  vpc_name = "vpc-${var.purpose}-${var.location}-001"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = local.vpc_name
  }
}
