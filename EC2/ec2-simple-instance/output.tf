# Outputs para Instancias EC2
output "instance_details" {
  description = "Detalles de la instancia EC2"
  value       = jsonencode({
    instance_id = aws_instance.my_ec2.id
    private_ip  = aws_instance.my_ec2.private_ip
    public_ip   = aws_instance.my_ec2.public_ip
  })
}

output "availability_zone" {
  description = "Zona de disponibilidad donde está la instancia"
  value       = aws_instance.my_ec2.availability_zone
}