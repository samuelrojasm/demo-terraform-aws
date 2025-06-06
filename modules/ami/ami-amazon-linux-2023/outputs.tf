output "ami_id" {
  description = "AMI ID for Amazon Linux 2023"
  value       = data.aws_ssm_parameter.al2023.value
}

output "ami_name" {
  description = "Name of the selected AMI"
  value       = data.aws_ami.al2023_details.name
}
