output "endpoint_ids" {
  value = { for k, ep in aws_vpc_endpoint.this : k => ep.id }
}

output "security_group_id" {
  value = aws_security_group.this.id
}