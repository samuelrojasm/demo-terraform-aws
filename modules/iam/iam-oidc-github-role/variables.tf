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
  description = "IAM policy JSON string"
  type        = string
}