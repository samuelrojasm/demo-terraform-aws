# Definición de valores de salida, para ver
# los detalles de la creación de las instancias EC2

output "ec2_info" {
  description = "Descripción de las instancias EC2 creadas"
  value = [
    for instance in aws_instance.ec2_family : {
      instance_id       = instance.id
      instance_type     = instance.instance_type
      ami_id            = instance.ami
      public_ip         = instance.public_ip
      private_ip        = instance.private_ip
      availability_zone = instance.availability_zone
      tags              = instance.tags
      state             = instance.state
    }
  ]
}