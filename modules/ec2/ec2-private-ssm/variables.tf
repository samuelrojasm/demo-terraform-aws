# Difinción de variables

# -----------------------------------------------------
# Atributos requeridos por el módulo: ec2-private-ssm
# -----------------------------------------------------
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

variable "ami_id" {
  description = "Amazon Machine Image (AMI)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}