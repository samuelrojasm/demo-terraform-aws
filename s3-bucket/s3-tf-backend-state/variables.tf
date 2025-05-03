#--------------------------------------------
# s3-tf-backend-state
# Asignación de valores a las varibales
#--------------------------------------------

variable "aws_region" {
  description = "Región de AWS donde se crean los recursos"
  type        = string
}