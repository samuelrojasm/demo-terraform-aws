variable "architecture" {
  description = "CPU architecture: x86_64 or arm64"
  type        = string
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "Only 'x86_64' or 'arm64' are supported."
  }
}

variable "ssm_parameter_name" {
  description = "SSM parameter path for Amazon Linux 2023 AMI"
  type        = string
  default     = ""
}

locals {
  default_paths = {
    x86_64 = "/aws/service/ami-amazon-linux-2023-latest/x86_64"
    arm64  = "/aws/service/ami-amazon-linux-2023-latest/arm64"
  }

  ssm_path = var.ssm_parameter_name != "" ? var.ssm_parameter_name : local.default_paths[var.architecture]
}
