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
variable "region" {
  description = "AWS Region"
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where to place the endpoints"
  type = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the endpoints"
  type = list(string)
}

variable "include_kms_endpoint" {
  description = "Whether to include the CloudWatch Logs endpoint"
  type    = bool
  default = false
}

variable "include_logs_endpoint" {
   description = "Whether to include the KMS endpoint"
  type    = bool
  default = false
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

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}