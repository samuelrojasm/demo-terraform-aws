# Definición de valores de salida,
# para ver los detalles de la creación

output "vpc_info" {
  description = "Detalles de la VPC creada"
  value = {
    id            = aws_vpc.vpc_igw.id
    cidr_block    = aws_vpc.vpc_igw.cidr_block
    arn           = aws_vpc.vpc_igw.arn
    tenancy       = aws_vpc.vpc_igw.instance_tenancy
    dns_support   = aws_vpc.vpc_igw.enable_dns_support
    dns_hostnames = aws_vpc.vpc_igw.enable_dns_hostnames
    name          = aws_vpc.vpc_igw.tags.Name
    default_sg    = aws_vpc.vpc_igw.default_security_group_id
    default_nacl  = aws_vpc.vpc_igw.default_network_acl_id
  }
}

output "detalles_private_subnets" {
  description = "Detalles de las subnets privadas creadas"
  value = [
    for subnet in aws_subnet.private_subnets : {
      id         = subnet.id
      cidr_block = subnet.cidr_block
      az         = subnet.availability_zone
      name       = subnet.tags.Name
    }
  ]
}

output "detalles_public_subnets" {
  description = "Detalles de las subnets privadas creadas"
  value = [
    for subnet in aws_subnet.public_subnets : {
      id         = subnet.id
      cidr_block = subnet.cidr_block
      az         = subnet.availability_zone
      name       = subnet.tags.Name
    }
  ]
}