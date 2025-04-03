# Reglas de entrada para los Security Groups

# Reglas de salida (permitir todo el tráfico)
resource "aws_security_group_rule" "allow_all_egress" {
  for_each          = local.security_groups # Usamos el mapa local de IDs de SGs
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] # allows all outbound traffic to any destination IP address
  security_group_id = each.value    # Aquí cada valor es un ID único de SG
  description       = "Allow all outbound traffic"
}

# SSH (solo desde subnets específicas)
resource "aws_security_group_rule" "ssh_rule" {
  security_group_id = aws_security_group.sg-web.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["10.0.1.0/24", "10.0.2.0/24"] # Allow traffic from private subnets
  description       = "SSH access from trusted IP"
}

# HTTP (acceso público)
resource "aws_security_group_rule" "allow_http" {
  security_group_id = aws_security_group.sg-web.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Any source IP address 
  description       = "Allow HTTP access"
}

# HTTPS (acceso público)
resource "aws_security_group_rule" "allow_https" {
  security_group_id = aws_security_group.sg-web.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Any source IP address 
  description       = "Allow HTTPS access"
}

# MySQL database connections
# Permitir acceso a una base de datos solo desde servidores web,
# al referenciar otro SG en lugar de usar direcciones IP
resource "aws_security_group_rule" "allow_mysql_from_web" {
  security_group_id        = aws_security_group.sg-database.id
  source_security_group_id = aws_security_group.sg-web.id # Referenciando otro Security Group
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  description              = "Allow DB access"
}