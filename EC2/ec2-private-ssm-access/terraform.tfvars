aws_region           = "us-east-1"
cidr_block           = "10.0.0.0/16"
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

purpose     = "SSM-managed private EC2"
project     = "demo-ec2-privada"
environment = "lab"