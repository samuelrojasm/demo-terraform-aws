###############################
# AWS EC2 SSM                 #
###############################

#---------------------------------------
# Role para EC2 con acceso a SSM
#---------------------------------------
resource "aws_iam_role" "this" {
  name               = "ec2-ssm-role"
  assume_role_policy = templatefile("${path.module}/assume-role-policy.tftpl", {})
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "this" {
  name = "ssm-instance-profile"
  role = aws_iam_role.this.name
}

#---------------------------------------
# Security Group para EC2
#---------------------------------------
resource "aws_security_group" "this" {
  name        = "ec2-private-sg"
  vpc_id      = var.vpc_id
  description = "Allow EC2 egress to VPCE on HTTPS"

  tags = merge(var.tags, {
    Name = "ec2-private-sg"
  })
}

#---------------------------------------
# EC2 privada
#---------------------------------------
resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.this.id]
  iam_instance_profile        = aws_iam_instance_profile.this.name
  associate_public_ip_address = false

  tags = merge(var.tags, {
    Name = "ec2-private-ssm"
  })
}