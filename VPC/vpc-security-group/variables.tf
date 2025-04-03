# Difinción de variables para que el cíodigo sea flexible

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

variable "security_groups" {
  type    = list(string)
  default = ["sg-database", "sg-web"] # IDs de SGs existentes
}
