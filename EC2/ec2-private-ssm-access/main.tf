
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
  private_subnets      = var.private_subnet_cidrs # lista de CIDR blocks
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false

  private_subnet_tags_per_az = {
    for az in var.availability_zones :
    az => {
      Name = "private-${var.project}-${az}"
    }
  }
  tags = local.tags
}

# ---------------------------------------------------
# Módulo: ec2-private-vpce-ssm (crea EC2 + VPCe)
# ---------------------------------------------------
module "ec2_ssm" {
  source = "../../modules/ec2/ec2-private-vpce-ssm"

  region        = var.aws_region
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnets # List of subnet IDs where to place the endpoints
  ami_id        = module.latest_al2023_x86_64_ami.ami_id
  instance_type = var.instance_type
  tags          = local.tags
}

# ---------------------------------------------------
# Módulo: ami-amazon-linux-2023 (Amazon Linux 2023)
# ---------------------------------------------------
module "latest_al2023_x86_64_ami" {
  source = "../../modules/ami/ami-amazon-linux-2023"
}