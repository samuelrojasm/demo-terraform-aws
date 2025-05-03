#--------------------------------------------
# s3-tf-backend-stat
#--------------------------------------------

output "vpc_name" {
  value = module.vpc.vpc_name
}

output "vpc_id" {
  description = "ID de la VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "IDs de subnets"
  value       = module.vpc.subnet_ids
}
