#---------------------------------------
# Valores de saida del módulo
#---------------------------------------
output "aws_instance_info" {
  value = aws_instance.this
}

output "sg_id" {
  description = "ID del Security Group asignado a la EC2"
  value       = aws_security_group.this.id

}