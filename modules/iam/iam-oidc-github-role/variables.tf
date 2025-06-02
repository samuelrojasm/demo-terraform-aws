variable "role_name" {
  description = "Nombre del IAM Role"
  type        = string
}

variable "aws_account_id" {
  description = "ID de la cuenta de AWS"
  type        = string
}

variable "repo_owner" {
  description = "GitHub org or username"
  type        = string
}

variable "repo_name" {
  description = "GitHub repo name"
  type        = string
}

variable "repo_branch" {
  description = "Branch to allow assume role from"
  type        = string
  default     = "main"
}

variable "policy_json" {
  description = "Documento JSON con la política personalizada que se creará y asignará al rol."
  type        = string
  default     = null
}

variable "policy_arn_list" {
  description = "Lista de ARNs de políticas IAM existentes a asociar al rol."
  type        = list(string)
  default     = []
}