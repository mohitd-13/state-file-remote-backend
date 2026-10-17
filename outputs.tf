output "state_bucket_name" {
  description = "Name of the State bucket storing Terraform state"
  value       = aws_s3_bucket.state_bucket.id
}

output "kms_key_alias" {
  description = "Alias of the KMS key used to encrypt the state bucket"
  value       = aws_kms_alias.state_bucket_kms.name
}
