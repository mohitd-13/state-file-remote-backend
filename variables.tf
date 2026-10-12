variable "aws_region" {
  description = "Name of the region for Terraform provisioned aws resources"
  type        = string
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket used for Terraform state storage"
  type        = string
}

variable "kms_deletion_window" {
  description = "Number of days before the KMS key is permanently deleted"
  type        = number
  default     = 10
}

variable "tags" {
  description = "Common tags to apply to all the Terraform State file backend resources"
  type        = map(string)
  default = {
    Project   = "state-file-remote-backend"
    ManagedBy = "terraform"
  }
}
