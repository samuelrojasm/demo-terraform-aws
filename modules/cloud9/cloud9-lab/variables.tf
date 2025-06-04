variable "name" {
  description = "Name of the Cloud9 environment"
  type        = string
}

variable "description" {
  type    = string
  default = "Cloud9 environment for labs"
}

variable "instance_type" {
  description = "Instance type for Cloud9"
  type        = string
  default     = "t3.small"
}

variable "image_id" {
  description = "The identifier for the Amazon Machine Image (AMI) that's used to create the EC2 instance"
  type        = string
  default     = "amazonlinux-2023-x86_64"
}

variable "subnet_id" {
  description = "Subnet ID where Cloud9 will be deployed"
  type        = string
}

variable "automatic_stop_time_minutes" {
  description = "Time in minutes to automatically stop the instance"
  type        = number
  default     = 60
}

variable "connection_type" {
  description = "The connection type used for connecting to an Amazon EC2 environment"
  type        = string
  default     = "CONNECT_SSM"
}

variable "tags" {
  description = "Tags to apply to the Cloud9 environment"
  type        = map(string)
  default     = {}
}