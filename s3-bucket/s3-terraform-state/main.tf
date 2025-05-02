#--------------------------------------------
# s3-terraform-state
# Creación de:
#   - S3 Bucket
#--------------------------------------------

# Generar nombres dinámicos
# Valor temporal calculado en tiempo de ejecución
locals {
  prefix = "${var.service}-${var.purpose}"
}

