#--------------------------------------------
# s3-terraform-state
# Asignación de valores a las varibales
#--------------------------------------------

aws_region         = "us-east-1" # Región de AWS donde se crean los recursos
purpose            = "demo"      # Objetivo de uso de los recursos
service            = "bucket"
prefix_bucket_name = "tf-state-infra"