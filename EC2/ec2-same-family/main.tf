# Definición de la EC2

# Generar nombres dinámicos
# Valor temporal calculado en tiempo de ejecución
locals {
  ec2_name = "ec2-${var.purpose}-${var.aws_region}"
}

# Crear instancias EC2
resource "aws_instance" "ec2_family" {
  count         = var.cantidad_instancias # Crea múltiples EC2
  ami           = var.ami_id              # Asocia el ami a las EC2
  instance_type = var.tipo_instancia      # Asigna el tipo de EC2

  tags = {
    Name = "${local.ec2_name}-${count.index + 1}" # Etiqueta dinámica: EC2 1, 2, 3...
    Env  = var.purpose
  }
}