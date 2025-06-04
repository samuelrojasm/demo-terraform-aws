variable "name" {
  type        = string
  description = "Name of the Cloud9 environment"
}

variable "description" {
  type        = string
  default     = "Cloud9 environment for labs"
}

variable "instance_type" {
  type        = string
  default     = "t3.small"
  description = "Instance type for Cloud9"
}

variable "image_id" {
  type        = string
  default     = "amazonlinux-2023-x86_64"
  description = "The identifier for the Amazon Machine Image (AMI) that's used to create the EC2 instance"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where Cloud9 will be deployed"
}

variable "automatic_stop_time_minutes" {
  type        = number
  default     = 60
  description = "Time in minutes to automatically stop the instance"
}

variable "connection_type" {
    type = string
    default = "CONNECT_SSM"
    description = "The connection type used for connecting to an Amazon EC2 environment"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the Cloud9 environment"
}