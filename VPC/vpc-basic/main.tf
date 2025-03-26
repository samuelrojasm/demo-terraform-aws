# Definición de VPC y Subred

# Generar nombres dinámicos
# Valor temporal calculado en tiempo de ejecución
locals {
  vpc_name            = "vpc-${var.purpose}-${var.aws_region}-001"
  private_subnet_name = "Private-Subnet-${var.purpose}"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = local.vpc_name
  }
}

resource "aws_subnet" "private_subnets" {
  count      = length(var.private_subnet_cidrs)               # Crea múltiples subnets dinámicamente
  vpc_id     = aws_vpc.vpc.id                                 # Asocia las subnets a la VPC principal
  cidr_block = element(var.private_subnet_cidrs, count.index) # Asigna el CIDR correspondiente a cada subnet

  tags = {
    Name = "${local.private_subnet_name}-${count.index + 1}" # Etiqueta dinámica: Private Subnet 1, 2, 3...
  }
}