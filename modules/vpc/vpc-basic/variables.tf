variable "name" {
  description = "Nombre base para los recursos"
  type        = string
  default = "vpc-basic"
}

variable "vpc_cidr" {
  description = "CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  description = "Lista de CIDRs para subnets"
  type        = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "Zonas de disponibilidad"
  type        = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "enable_dns_hostnames" {
  description = "Habilita DNS hostnames en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilita soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Etiquetas adicionales"
  type        = map(string)
  default     = {
    Environment = "default"
  }
}
