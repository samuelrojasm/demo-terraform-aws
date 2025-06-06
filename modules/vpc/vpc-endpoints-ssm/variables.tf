#----------------------------------------
# Atributos del módulo: vpc-endpoints-ssm
#----------------------------------------
variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where to place the endpoints"
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

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}