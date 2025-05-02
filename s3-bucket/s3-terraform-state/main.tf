#--------------------------------------------
# s3-terraform-state
# Creación de:
#     S3 Bucket
#--------------------------------------------

# Generar nombres dinámicos
# Valor temporal calculado en tiempo de ejecución
locals {
  prefix = "${var.purpose}-${var.service}"
}

resource "aws_s3_bucket" "bucket_tf_state" {
  bucket        = "${local.prefix}-${var.prefix_bucket_name}-01"
  force_destroy = true

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "${var.purpose}"
  }
}

# Provides a S3 bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_encryption" {
  bucket = aws_s3_bucket.bucket_tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Provides a resource for controlling versioning on an S3 bucket
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.bucket_tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state_block_public" {
  bucket = aws_s3_bucket.bucket_tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bloquea el uso de ACLs
resource "aws_s3_bucket_ownership_controls" "tf_state_ownership" {
  bucket = aws_s3_bucket.bucket_tf_state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}