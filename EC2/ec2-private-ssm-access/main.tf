
# -----------------------------------------------
# Variables locales
# -----------------------------------------------
locals {
  tags = {
    Environment = var.environment
    Project     = var.project
    Purpose     = var.purpose
  }
}

# -----------------------------------------------
# Módulo: VPC con subredes privadas
# -----------------------------------------------
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "vpc-${var.project}"
  cidr = var.cidr_block

  azs                  = var.availability_zones
  private_subnets      = var.private_subnet_cidrs
  enable_dns_hostnames = true
  enable_dns_support   = true

  private_subnet_tags = {
    "Name" = "private-subnet-${var.project}"
  }

  tags = local.tags
}

# -----------------------------------------------
# Módulo: ec2-private-vpce-ssm (crea EC2 + VPCe)
# -----------------------------------------------
module "ec2_ssm" {
  source = "../../modules/ec2/ec2-private-vpce-ssm"

  region              = var.aws_region
  vpc_id              = var.vpc_id
  subnet_id           = var.private_subnet_ids[0].id
  subnet_ids          = var.vpc.subnet_ids
  allowed_cidr_blocks = var.private_subnet_cidrs
  ami                 = module.latest_al2023_x86_64_ami.ami_id
  sg-id-ec2           = ""
  tags                = local.tags
}

# ------------------------------------------------
# Módulo: ami-amazon-linux-2023 (Amazon Linux 2023)
# ------------------------------------------------
module "latest_al2023_x86_64_ami" {
  source = "../../modules/ami/ami-amazon-linux-2023"
}