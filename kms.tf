# KMS key for the Terraform Statefile Bucket server side encryption
resource "aws_kms_key" "state_bucket_kms" {
  description             = "KMS key for the Terraform State File bucket"
  deletion_window_in_days = var.kms_deletion_window
  enable_key_rotation     = true

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(var.tags, { Name = "terraform-statefile-bucket-kms" })
}

# Alias for kms key, instead of using kms key id
resource "aws_kms_alias" "state_bucket_kms" {
  name          = "alias/${var.state_bucket_name}-key"
  target_key_id = aws_kms_key.state_bucket_kms.id
}
