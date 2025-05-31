variable "role_name" {
  description = "Nombre del IAM Role"
  type        = string

}

variable "oidc_provider_arn" {
  description = "ARN del proveedor OIDC (por ejemplo, GitHub)"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
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