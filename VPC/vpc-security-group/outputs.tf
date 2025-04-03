output "security_groups" {
  value = {
    "web" = {
      id          = aws_security_group.sg-web.id
      arn         = aws_security_group.sg-web.arn
      name        = aws_security_group.sg-web.name
      description = aws_security_group.sg-web.description
      vpc_id      = aws_security_group.sg-web.vpc_id
    }
    "db" = {
      id          = aws_security_group.sg-database.id
      arn         = aws_security_group.sg-database.arn
      name        = aws_security_group.sg-database.name
      description = aws_security_group.sg-database.description
      vpc_id      = aws_security_group.sg-database.vpc_id
    }
  }
}
