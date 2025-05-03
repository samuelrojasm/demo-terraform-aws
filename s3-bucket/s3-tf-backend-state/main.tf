#--------------------------------------------
# s3-tf-backend-stat
# Objetivo:
#   Validar el uso de backend state
# Definición de:
#   Crea una VPC
#   Usa el módulo vpc-basic
#--------------------------------------------

module "vpc" {
  source = "../../modules/vpc/vpc-basic"
}