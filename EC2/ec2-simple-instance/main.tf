locals {
  extra_tag = "extra-tag"
}

# Crear una instancia EC2
resource "aws_instance" "my_ec2" {
  ami           = "ami-05b10e08d247fb927" # Amazon Linux 2023 64-bit(x86) en us-east-01
  instance_type = "t2.micro"


  # Etiquetas para identificar la instancia
  tags = {
    Name     = var.ec2_name
    ExtraTag = local.extra_tag
  }
}