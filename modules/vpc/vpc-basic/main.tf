resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(var.tags, {
    Name = var.name
  })
}

resource "aws_subnet" "subnets" {
  count             = length(var.subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnets[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "subnet-${var.name}-${count.index}"
  }
}