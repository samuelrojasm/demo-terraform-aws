#-----------------------------------------------------------------------
# Crea el provider OIDC para GitHub
#-----------------------------------------------------------------------
resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  # thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] # GitHub OIDC - Ya no es necesario - Como mejor práctica para evitar actualizacione futuras

  tags = {
    Name    = "${var.purpose}"
    Service = "${var.service}"
  }
}