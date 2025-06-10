# Definimos las entradas que aceptará el módulo

variable "orchestrator" {
  description = "El orquestador para el que se necesita la AMI (e.g., 'eks', 'ecs')."
  type        = string
  validation {
    condition     = contains(["eks", "ecs"], var.orchestrator)
    error_message = "El orquestador debe ser 'eks' o 'ecs' "
  }
}

variable "architecture" {
  description = "La arquitectura de la AMI ('x86_64', 'arm64')."
  type        = string
  default = "x86_64"
  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "La arquitectura debe ser 'x86_64' o 'arm64'."
  }
}

variable "kubernetes_version" {
  description = "La versión de Kubernetes (solo si orchestrator es 'eks')."
  type        = string
  default     = null # Opcional, dependiendo de si siempre esperas un valor cuando orchestrator es 'eks'

  # Validación 1: Asegurar que no es NULL si es eks
  validation {
    condition     = var.orchestrator != "eks" || var.kubernetes_version != null
    error_message = "Para 'eks', 'kubernetes_version' debe ser proporcionado y no puede ser nulo."
  }

  # Validación 2: Formato correcto, si orchestrator es 'eks'
  # Usamos try() para evitar errores si kubernetes_version es null aquí
  validation {
    condition = var.orchestrator != "eks" || (
      try(can(regex("^[0-9]+\\.[0-9]+$", var.kubernetes_version)), false)
    )
    error_message = "La versión de Kubernetes debe tener el formato 'X.YY' (e.g., '1.29')."
  }

  # Validación 3: Versión de Kubernetes > 1.26 si es EKS
  validation {
    condition = var.orchestrator != "eks" || (
      try(
        length(regexall("^([0-9]+)\\.([0-9]+)$", var.kubernetes_version)) > 0 &&
        (
            tonumber(regexall("^([0-9]+)\\.([0-9]+)$", var.kubernetes_version)[0][0]) > 1 ||
            (
                tonumber(regexall("^([0-9]+)\\.([0-9]+)$", var.kubernetes_version)[0][0]) == 1 &&
                tonumber(regexall("^([0-9]+)\\.([0-9]+)$", var.kubernetes_version)[0][1]) > 26
            )
        ), 
        false # Si algo dentro del 'try' falla (ej. kubernetes_version es null), devuelve false.
      )
    )
    error_message = "Si el orquestador es 'eks', la versión de Kubernetes debe ser superior a 1.26 (ej. 1.27, 1.28, 1.29 o superior)."
  }

  # Validación 4: Si FIPS está habilitado y es EKS, la versión de Kubernetes debe ser >= 1.28
  # FIPS en Bottlerocket para EKS solo está disponible a partir de la versión 1.28 de Kubernetes (aws-k8s-1.28-fips)
  # Solo aplica si fips_support es true Y orchestrator es 'eks'
  validation {
    condition = !(var.fips_support && var.orchestrator == "eks") || (
        try(
            length(regexall("^([0-9]+)\\.([0-9]+)$", var.kubernetes_version)) > 0 &&
            (
                tonumber(regexall("^([0-9]+)\\.([0-9]+)$", var.kubernetes_version)[0][0]) > 1 || # Si la versión mayor es > 1
                (
                    tonumber(regexall("^([0-9]+)\\.([0-9]+)$", var.kubernetes_version)[0][0]) == 1 && # Si la versión mayor es 1 Y
                    tonumber(regexall("^([0-9]+)\\.([0-9]+)$", var.kubernetes_version)[0][1]) >= 28   # la versión menor es >= 28
                )
            ), false # Si algo dentro del 'try' falla, devuelve false.
        )
    )
    error_message = "Para Bottlerocket EKS FIPS, la versión de Kubernetes debe ser 1.28 o superior (ej. '1.28', '1.29')."
  }
}

variable "gpu_support" {
  # Disponible un Paramter Storea a partir de la versión 1.21
  # /aws-k8s-1.21-nvidia
  description = "Indica si la AMI debe tener soporte para GPU."
  type        = bool
  default     = false

  validation {
    # Validación de exclusividad mutua: No puede ser true si fips_support también es true.
    condition     = !(var.gpu_support && var.fips_support)
    error_message = "Las opciones 'gpu_support' y 'fips_support' no pueden ser habilitadas simultáneamente."
  }
}

variable "fips_support" {
  description = "Indica si la AMI debe tener soporte FIPS."
  type        = bool
  default     = false
  # No se necesita una validación aquí si ya está en gpu_support
}

variable "bottlerocket_variant_map" {
  description = "Mapa que define los prefijos de las rutas de Bottlerocket por orquestador y otras características."
  type = map(object({
    base_prefix = string
    eks_prefix  = string
    ecs_prefix  = string
    gpu_suffix  = string
    fips_suffix = string
  }))
  # Valores predeterminados basados en las convenciones actuales de Bottlerocket
  default = {
    "default" = {
      base_prefix = "/aws/service/bottlerocket"
      eks_prefix  = "aws-k8s"
      ecs_prefix  = "aws-ecs-2" # Usamos aws-ecs-2 como la más común o reciente
      gpu_suffix  = "-nvidia"
      fips_suffix = "-fips"
    }
  }
}