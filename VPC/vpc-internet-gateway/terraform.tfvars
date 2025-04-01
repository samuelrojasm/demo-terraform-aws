# Asignación de valores a las varibales

aws_region           = "us-east-1" # Región de AWS donde se crean los recursos
purpose              = "demo"      # Objetivo de uso de los recursos
cidr_block           = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]