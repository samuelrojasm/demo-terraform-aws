module "ec2_ssm" {
  source = "./modules/ec2-ssm"

  vpc_id     = var.vpc_id
  subnet_id  = var.private_subnet_id
  tags       = var.tags
}

module "vpce_ssm" {
  source = "./modules/vpce-ssm"

  vpc_id           = var.vpc_id
  subnet_ids       = var.private_subnet_ids
  allowed_cidr     = var.vpc_cidr_block
  tags             = var.tags
}