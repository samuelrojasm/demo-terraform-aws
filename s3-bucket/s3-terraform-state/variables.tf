#--------------------------------------------------------
# s3-terraform-state
# Difinción de variables para que el código sea flexible
#--------------------------------------------------------

variable "aws_region" {
  description = "Región de AWS donde se crean los recursos"
  type        = string
}

variable "purpose" {
  description = "Propósito de los recursos (demo,lab,dev,prod)"
  type        = string
}

variable "service" {
  description = "Nombre del servicio"
  type        = string
}

variable "prefix_bucket_name" {
  description = "Nombre del Bucket"
  type        = string
}

