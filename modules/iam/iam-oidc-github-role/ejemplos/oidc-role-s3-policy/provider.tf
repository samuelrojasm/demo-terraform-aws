#------------------------------------------------
# Configurar AWS provider
# Iniciar sesión con las credenciales definidas
#------------------------------------------------
terraform {
  required_version = ">= 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuración del proveedor AWS
provider "aws" {
  profile = "tf" # Nombre del perfil configurado en AWS CLI con IAM Identity Center
}