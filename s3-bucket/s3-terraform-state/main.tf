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
  bucket = "${local.prefix}-${var.prefix_bucket_name}-01"
  tags = {
    Name        = "Terraform State Bucket"
    Environment = "${var.purpose}"
  }
}

# Provides a S3 bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.bucket_tf_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket_tf_state.id
  acl    = "private"
}

# Provides a resource for controlling versioning on an S3 bucket
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket_tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}