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
  availability_zone = element(var.azs, count.index)

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

# Segunda route table, es una mejor práctica para
# habilitar el tráfico desde Internet para acceder
# a las Public Subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_igw.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rt-public-${var.purpose}"
  }
}

# Asociar de manera explicita, todas las  public subnets con
# la segunda route table, para habilitar el acceso a Internet en estas.
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}