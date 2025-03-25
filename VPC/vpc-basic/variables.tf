# Difinción de variables

variable "location" {
  description = "Ubicación de la VPC"
  type = string   
}

variable "service" {
  description = "Nombre del servicio"
  type = string
}

variable "purpose" {
    description = "Propósito de uso de los recursos (demo, lab, test, dev, prod)"
    type = string
}

# Nombres generados dinámicamente



