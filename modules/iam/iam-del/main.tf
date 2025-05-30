#-----------------------------------------------------------------------
# Crea el provider OIDC para GitHub
# Notas:
#   El thumbprint puede cambiar ya este es el sha1 fingerprint de GitHub
#-----------------------------------------------------------------------
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] # GitHub OIDC
}