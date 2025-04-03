# Definición de la VPC y Security Groups

# Generar nombres dinámicos
# Valor temporal calculado en tiempo de ejecuci√≥n
locals {
  vpc_name = "vpc-${var.purpose}-${var.aws_region}-01"
}

# Definición de la VPC
resource "aws_vpc" "vpc_sg" {
  cidr_block = var.cidr_block

  tags = {
    Name = local.vpc_name
  }
}

# Security Group asociado a la VPC personalizada
resource "aws_security_group" "sg-ec2" {
  name        = "ec2-security-group"
  description = "Reglas de seguridad para EC2"
  vpc_id      = aws_vpc.vpc_sg.id # Aquí se define la VPC donde estará el SG

  # Reglas de salida (permitir todo el tráfico)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # allows all outbound traffic to any destination IP address
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "sg-ec2-${var.purpose}"
  }
}

# Security Group asociado a la VPC personalizada
resource "aws_security_group" "sg-db" {
  name        = "db-security-group"
  description = "Reglas de seguridad para DataBase"
  vpc_id      = aws_vpc.vpc_sg.id # Aquí se define la VPC donde estará el SG

  # Reglas de salida (permitir todo el tráfico)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # allows all outbound traffic to any destination IP address
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "sg-db-${var.purpose}"
  }
}




