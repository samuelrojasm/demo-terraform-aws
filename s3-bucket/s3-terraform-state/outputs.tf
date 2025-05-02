#--------------------------------------------
# s3-terraform-state
# Outputs del Bucket
#--------------------------------------------

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket_tf_state.bucket
}