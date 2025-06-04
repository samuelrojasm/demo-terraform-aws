#-----------------------------------------------
# Creación de VPC para la instancia de Cloud9
#-----------------------------------------------
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-cloud9-lab"
  cidr = var.cidr_block

  azs             = [var.aws_region + "a"]
  private_subnets = var.private_subnet_cidrs

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.purpose
  }
}