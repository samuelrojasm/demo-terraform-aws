terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configuración del proveedor AWS
provider "aws" {
  region  = "us-east-1" # Región de AWS donde se crean los recursos
  profile = "tf"        # Nombre del perfil configurado en AWS CLI con IAM Identity Center
}
