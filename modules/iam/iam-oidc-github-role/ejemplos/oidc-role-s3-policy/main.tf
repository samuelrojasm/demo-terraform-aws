locals {
  bucket_arn         = "arn:aws:s3:::${var.s3_bucket_name}"
  bucket_objects_arn = "arn:aws:s3:::${var.s3_bucket_name}/*"

  github_actions_policy_json = templatefile("${path.module}/github-actions-policy.tftpl", {
    bucket_arn         = local.bucket_arn
    bucket_objects_arn = local.bucket_objects_arn
  })
}

module "github_oidc_role" {
  source         = "../../"
  role_name      = "github-actions-demo-role"
  aws_account_id = "1234567890"
  repo_owner     = "miusuario"
  repo_name      = "demo-gitops-repo"
  repo_branch    = "main"
  policy_json    = local.github_actions_policy_json
  # policy_json    = null
  # policy_arn_list = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess","arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"]
}