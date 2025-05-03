# Exponer 

output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.this.id
}

output "vpc_name" {
  value = aws_vpc.this.tags["Name"]
}

output "subnet_ids" {
  description = "IDs de subnets"
  value       = aws_subnet.subnets[*].id
}

output "subnets_ids" {
  value = [for subnet in aws_subnet.subnets : subnet.id]
}
