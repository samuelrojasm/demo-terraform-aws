#-----------------------------------------
# modules/ec2/ec2-private-vpce-ssm/main.tf
#-----------------------------------------
module "ec2_ssm" {
  source = "./modules/ec2-ssm"

  vpc_id     = var.vpc_id
  subnet_id  = var.private_subnet_id
  ami_id     = var.ami_id
  instance_type = var.instance_type
  tags       = var.tags
}

module "vpce_ssm" {
  source = "./modules/vpce-ssm"

  vpc_id              = var.vpc_id
  private_subnet_ids  = var.private_subnet_ids
  region              = var.region
  tags                = var.tags
}

