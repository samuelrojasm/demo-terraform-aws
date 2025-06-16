variable "architecture" {
  description = "La arquitectura de la AMI ('x86_64', 'arm64', 'neuron', 'gpu')"
  type        = string
  default     = "x86_64" # La arquitectura predeterminada si no se especifica.
  validation {
    condition     = contains(["x86_64", "arm64", "neuron", "gpu"], var.architecture)
    error_message = "La arquitectura debe ser 'x86_64' 'arm64' 'neuron' o 'gpu'"
  }
}