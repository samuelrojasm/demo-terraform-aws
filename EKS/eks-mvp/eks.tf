# ---------------------------------
# EKS Cluster
# ---------------------------------
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  eks_managed_node_groups = {
    spot_nodes = {
      instance_types = var.spot_instance_types
      capacity_type  = "SPOT"
      desired_size   = 2
      max_size       = 3
      min_size       = 1

      name = "${var.cluster_name}-spot-ng"

      tags = {
        Name = "eks-spot-node"
      }
    }
  }

  tags = {
    Environment = var.purpose
    Project     = "${var.service}-${var.purpose}"
  }
}