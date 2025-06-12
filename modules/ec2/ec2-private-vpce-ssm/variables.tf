# -----------------------------------------------------
# Atributos requeridos por el módulo: ec2-private-ssm
# -----------------------------------------------------
variable "instance_type" {
  description = "Type of EC2"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image (AMI)"
  type        = string
}

#----------------------------------------
# Atributos del módulo: vpc-endpoints-ssm
#----------------------------------------
variable "region" {
  description = "AWS Region"
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

#---------------------------------------------------------------
# Atributos comunes entre módulos
#---------------------------------------------------------------
variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}