# Definición de la VPC y Security Groups

# Generar nombres dinámicos
# Valor temporal calculado en tiempo de ejecuci√≥n
locals {
  vpc_name = "vpc-${var.purpose}-${var.aws_region}-01"
  security_groups = {
    "web" = aws_security_group.sg-web.id
    "db"  = aws_security_group.sg-database.id
  }
}

# Definición de la VPC
resource "aws_vpc" "vpc_sg" {
  cidr_block = var.cidr_block

  tags = {
    Name = local.vpc_name
  }
}

# Security Group asociado a la VPC personalizada
resource "aws_security_group" "sg-web" {
  name        = "security_group_web"
  description = "Reglas de seguridad para Web Servers"
  vpc_id      = aws_vpc.vpc_sg.id # Aquí se define la VPC donde estará el SG

  tags = {
    Name = "sg-web-${var.purpose}"
  }
}

# Security Group asociado a la VPC personalizada
resource "aws_security_group" "sg-database" {
  name        = "security_group_database"
  description = "Reglas de seguridad para Base de Datos"
  vpc_id      = aws_vpc.vpc_sg.id # Aquí se define la VPC donde estará el SG

  tags = {
    Name = "sg-database-${var.purpose}"
  }
}


