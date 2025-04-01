# Difinción de variables para que el código sea flexible

variable "aws_region" {
  description = "Región de AWS donde se crean los recursos"
  type        = string
}

variable "purpose" {
  description = "Propósito de los recursos (demo,lab,dev,prod)"
  type        = string
}

variable "cidr_block" {
  description = "Rango de direcciones IP para la VPC"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "Valores CIDR de la Private Subnet"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Valores CIDR de la Public Subnet"
  type        = list(string)
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}