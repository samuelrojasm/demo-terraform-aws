# Definici√≥n de valores de salida,
# para ver los detalles de la creación

output "vpc_info" {
  description = "Detalles de la VPC creada"
  value = {
    id            = aws_vpc.vpc.id
    cidr_block    = aws_vpc.vpc.cidr_block
    default_vpc   = aws_vpc.vpc.default
    arn           = aws_vpc.vpc.arn
    tenancy       = aws_vpc.vpc.instance_tenancy
    dns_support   = aws_vpc.vpc.enable_dns_support
    dns_hostnames = aws_vpc.vpc.enable_dns_hostnames
    name          = aws_vpc.vpc.tags.Name
  }
}

output "detalles_private_subnet" {
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