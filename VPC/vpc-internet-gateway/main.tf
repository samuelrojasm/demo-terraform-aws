# Definición de la VPC 

# Generar nombres dinámicos
# Valor temporal calculado en tiempo de ejecución
locals {
  vpc_name            = "vpc-${var.purpose}-${var.aws_region}-01"
  private_subnet_name = "Private-Subnet-${var.purpose}"
  public_subnet_name  = "Public-Subnet-${var.purpose}"
}

resource "aws_vpc" "vpc_igw" {
  cidr_block = var.cidr_block

  tags = {
    Name = local.vpc_name
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)               # Crea múltiples subnets dinámicamente
  vpc_id            = aws_vpc.vpc_igw.id                             # Asocia las subnets a la VPC principal
  cidr_block        = element(var.private_subnet_cidrs, count.index) # Asigna el CIDR correspondiente a cada subnet
  availability_zone = elemnet(var.azs, count.index)

  tags = {
    Name = "${local.private_subnet_name}-${count.index + 1}" # Etiqueta dinámica: Private Subnet 1, 2, 3...
  }
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)               # Crea múltiples subnets dinámicamente
  vpc_id            = aws_vpc.vpc_igw.id                            # Asocia las subnets a la VPC principal
  cidr_block        = element(var.public_subnet_cidrs, count.index) # Asigna el CIDR correspondiente a cada subnet
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${local.public_subnet_name}-${count.index + 1}" # Etiqueta dinámica: Public Subnet 1, 2, 3...
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_igw.id

  tags = {
    Name = "igw-${var.purpose}-${var.aws_region}"
  }
}