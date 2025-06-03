aws_region           = "us-east-1"
cluster_name         = "eks-mvp-cluster"
spot_instance_types  = ["t3.small", "t3.medium"]
cidr_block           = "10.0.0.0/16"
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

purpose = "test-mpv"
service = "eks"