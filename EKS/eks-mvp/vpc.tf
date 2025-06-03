# ---------------------------------
# VPC y subredes privadas
# ---------------------------------
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "${var.cluster_name}-vpc"
  cidr = var.cidr_block

  azs                  = var.availability_zones
  private_subnets      = var.private_subnet_cidrs
  enable_dns_hostnames = true
  enable_dns_support   = true

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"           = "1"      # Marca esta subred como válida para ELB internos (servicios privados).
    "kubernetes.io/cluster/${var.cluster_name}" = "shared" # Permite que EKS descubra la subred como parte del clúster.
    "Name"                                      = "${var.cluster_name}-private-subnet"
  }

  tags = {
    Environment = var.purpose
    Project     = "${var.service}-${var.purpose}"
  }
}