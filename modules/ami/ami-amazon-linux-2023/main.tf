data "aws_ssm_parameter" "al2023" {
  name = var.ssm_parameter_name
}

data "aws_ami" "al2023_details" {
  most_recent = false
  owners      = ["137112412989"]

  filter {
    name   = "image-id"
    values = [data.aws_ssm_parameter.al2023.value]
  }
}







data "aws_ami" "this" {
  most_recent = true
  owners      = [var.owner] # AMI owner ID

  filter {
    name   = "name"
    values = [var.name_prefix]
  }

  filter {
    name   = "architecture"
    values = [var.architecture]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
