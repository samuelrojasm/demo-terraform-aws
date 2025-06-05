#-----------------------------------------
# modules/ec2/ec2-private-vpce-ssm/main.tf
#-----------------------------------------
module "ec2_ssm" {
  source = "../ec2-private-ssm"

  project = var.project
  environment = var.environment
 purpose = var.purpose
vpc_id     = var.vpc_id
subnet_id  = var.private_subnet_id
  ami   = var.ami
  instance_type = var.instance_type
  vpce_sg_id = var.vpce_sg_id
  tags       = var.tags

}

module "vpce_ssm" {
  source = "../../vpc/vpce-ssm"

  vpc_id              = var.vpc_id
  private_subnet_ids  = var.private_subnet_ids
  region              = var.region
  tags                = var.tags
}

