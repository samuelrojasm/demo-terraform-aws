
# -----------------------------------------------------
# Atributos requeridos por el módulo: ec2-private-ssm
# -----------------------------------------------------
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
  description = "Amazon Machine Image (AMI)"
  type        = string
}

#----------------------------------------
# Atributos del módulo: vpc-endpoints-ssm
#----------------------------------------
variable "aws_region" {
  description = "La región donde se desplegarán los recursos de AWS"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where to place the endpoints"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the endpoints"
  type        = list(string)
}

# Datos de la VPC
variable "cidr_block" {
  description = "Rango de direcciones IP para la VPC"
  type        = string
}

variable "include_kms_endpoint" {
  description = "Whether to include the CloudWatch Logs endpoint"
  type        = bool
  default     = false
}

variable "include_logs_endpoint" {
  description = "Whether to include the KMS endpoint"
  type        = bool
  default     = false
}

variable "sg-id-ec2" {
  description = "ID de Security Group asignado a la EC2 SSM"
  type        = string
}

#---------------------------------------------------------------
# Atributos comunes entre módulos
#---------------------------------------------------------------
variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "Valores CIDR de la Private Subnet"
  type        = list(string)
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para HA"
  type        = list(string)
}

variable "project" {
  description = "Nombre del proyecto"
  type        = string
}

variable "purpose" {
  description = "Propósito de uso de los recursos"
  type        = string
}

variable "environment" {
  description = "Entorno (demo, lab, test, dev, prod)"
  type        = string
  default     = "lab"
}
