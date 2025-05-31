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