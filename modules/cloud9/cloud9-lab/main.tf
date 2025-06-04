resource "aws_cloud9_environment_ec2" "this" {
  name                        = var.name
  description                 = var.description
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  automatic_stop_time_minutes = var.automatic_stop_time_minutes
  image_id                    = var.image_id
  connection_type             = var.connection_type
  tags                        = var.tags
}