#--------------------------------------------
# s3-tf-backend-state
# Configurar el Backend
#--------------------------------------------

terraform {
  backend "s3" {
    bucket  = "demo-bucket-tf-state-infra-01"
    key     = "tf-state/demo/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}