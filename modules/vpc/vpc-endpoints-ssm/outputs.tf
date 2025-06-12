#--------------------------------------------------
# Valores de salida del módulo vpc-endpoints-ssm
#--------------------------------------------------

output "endpoint_ids" {
  value = { for k, ep in aws_vpc_endpoint.this : k => ep.id }
}

output "sg_id" {
  description = "ID del Security Group asignado a los VPC endpoints"
  value       = aws_security_group.this.id
}