output "endpoint_ids" {
  value = { for k, ep in aws_vpc_endpoint.ssm_endpoints : k => ep.id }
}

output "security_group_id" {
  value = aws_security_group.this.id
}