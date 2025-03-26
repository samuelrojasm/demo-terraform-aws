# Difinción de variables

variable "aws_region" {
  description = "La región donde se desplegarán los recursos de AWS"
  type        = string
}

variable "service" {
  description = "Nombre del servicio"
  type        = string
}

variable "purpose" {
  description = "Propósito de uso de los recursos (demo, lab, test, dev, prod)"
  type        = string
}

# Datos de la VPC
variable "cidr_block" {
  description = "Rango de direcciones IP para la VPC"
  type        = string
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Valores CIDR de la Private Subnet"
}