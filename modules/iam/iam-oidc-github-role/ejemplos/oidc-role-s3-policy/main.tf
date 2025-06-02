locals {
  bucket_arn         = "arn:aws:s3:::${var.s3_bucket_name}"
  bucket_objects_arn = "arn:aws:s3:::${var.s3_bucket_name}/*"

  github_actions_policy_json = templatefile("${path.module}/github-actions-policy.tftpl", {
    bucket_arn         = local.bucket_arn
    bucket_objects_arn = local.bucket_objects_arn
  })
}

resource "aws_iam_policy" "github_actions_policy" {
  name        = "${var.role_name}-policy"
  description = "Policy for GitHub Actions Terraform access"
  policy      = local.github_actions_policy_json
}
