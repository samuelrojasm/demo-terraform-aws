#------------------------------------------
# Atributos del módulo: vpc
#------------------------------------------
variable "cidr_block" {
  description = "Rango de direcciones IP para la VPC"
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

# -----------------------------------------------------------------
# Varibales para módulo: ec2-private-vpce-ssm (crea EC2 + VPCe)
# -----------------------------------------------------------------
variable "instance_type" {
  description = "Type of EC2"
  type        = string
  default     = "t3.micro"
}

variable "aws_region" {
  description = "La región donde se desplegarán los recursos de AWS"
  type        = string
}

variable "include_kms_endpoint" {
  description = "Whether to include the KMS endpoint"
  type        = bool
  default     = false
}

variable "include_logs_endpoint" {
  description = "Whether to include the CloudWatch Logs endpoint"
  type        = bool
  default     = false
}

#---------------------------------------------------------------
# Variables para creación de tags
#---------------------------------------------------------------
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
