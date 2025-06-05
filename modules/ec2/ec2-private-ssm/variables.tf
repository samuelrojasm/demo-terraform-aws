# Difinción de variables

# -----------------------------------------------------
# Atributos requeridos por el módulo: ec2-private-ssm
# -----------------------------------------------------
variable "project" {
  description = "Nombre del proyecto"
  type        = string
  default     = "demo"
}

variable "environment" {
  description = "Entorno (demo, lab, test, dev, prod)"
  type        = string
  default     = "lab"
}

variable "purpose" {
  description = "Propósito de uso de los recursos"
  type        = string
  default     = "SSM-managed private EC2"
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where to place the EC2"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2"
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  description = "Type of EC2"
  type        = string
}
