# Remote S3 bucket for storing Terraform states
resource "aws_s3_bucket" "state_bucket" {
  bucket              = var.state_bucket_name
  object_lock_enabled = true

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(var.tags, { Name = "state-file-bucket" })
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "state_bucket_versioning" {
  bucket = aws_s3_bucket.state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket_encryption" {
  bucket = aws_s3_bucket.state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.state_bucket_kms.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# Enable public access block for the S3 bucket
resource "aws_s3_bucket_public_access_block" "state_bucket_public_access" {
  bucket = aws_s3_bucket.state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
