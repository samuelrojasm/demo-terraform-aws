#-----------------------------------------
# modules/ec2/ec2-private-vpce-ssm/main.tf
#-----------------------------------------
module "ec2_ssm" {
  source = "../ec2-private-ssm"

  vpc_id        = var.vpc_id
  subnet_id     = var.subnet_id
  ami           = var.ami
  instance_type = var.instance_type
  tags          = var.tags
}

module "vpce_ssm" {
  source = "../../vpc/vpce-ssm"

  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  region             = var.region
  tags               = var.tags
}