#-----------------------------------------------
# Path: modules/ec2/ec2-private-vpce-ssm/main.tf
#-----------------------------------------------

#-----------------------------------------------
# Módulo:ec2-private-ssm (Crea EC2 con SSM)
#-----------------------------------------------
module "ec2_ssm" {
  source = "../ec2-private-ssm"

  vpc_id        = var.vpc_id
  subnet_id     = var.subnet_ids[0]
  ami_id        = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
}

#-----------------------------------------------
# Módulo:vpc-endpoints-ssm (Crea VPC Endpoints)
#-----------------------------------------------
module "vpce_ssm" {
  source = "../../vpc/vpc-endpoints-ssm"

  region     = var.region
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  tags       = var.tags
}