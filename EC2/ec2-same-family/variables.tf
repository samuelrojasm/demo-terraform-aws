# Difinción de variables para que el código sea flexible

variable "aws_region" {
    description = "Región de AWS donde se crean los recursos"
    type = string
}

variable "purpose" {
  description = "Propósito de los recursos (demo,lab,dev,prod)"
  type = string
}

variable "cantidad_instancias" {
    description = "Cantidad de Ec2 que se crean"
    type = number
}

variable "tipo_instancia" {
  description = "Describe el tipo de instancia"
  type = string
}

variable "ami_id" {
    description = "El id de la imagen que se usa para crear las instancias"
    type = string
}