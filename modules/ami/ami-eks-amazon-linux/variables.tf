variable "kubernetes_version" {
  description = "La versión de Kubernetes para la que se necesita la AMI optimizada de EKS ('1.29', '1.28')"
  type        = string
  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+$", var.kubernetes_version))
    error_message = "La versión de Kubernetes debe tener el formato 'X.YY' ('1.29')."
  }
}

variable "architecture" {
  description = "La arquitectura de la AMI ('x86_64', 'arm64')"
  type        = string
  default     = "x86_64" # La arquitectura predeterminada si no se especifica.
  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "La arquitectura debe ser 'x86_64' o 'arm64'"
  }
}

variable "ami_type" {
  description = "El sabor de la AMI optimizada de EKS ('standard', 'nvidia', 'neuron')"
  type        = string
  default     = "standard" # El tipo más común para AMIs optimizadas (la última estable).
  validation {
    condition     = contains(["standard", "nvidia", "neuron"], var.ami_type)
    error_message = "El tipo de la AMI debe ser 'standard', 'nvidia' o 'neuron'"
  }
}