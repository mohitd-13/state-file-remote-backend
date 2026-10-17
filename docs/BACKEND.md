### REMOTE BACKEND

## WHY USE REMOTE BACKEND?

By default, Terraform stores state locally in a file named `terraform.tfstate`. This makes working with Terrform in a team complicated. If two team members run `terraform apply` at the same time, they ended up overwriting each other's changes. If your laptop's hard drive fails, you lose the state and Terraform no longer knows what resources it manages. Failing to share the latest state with team can result in a state that is out of sync with reality.

To solve these problems we use a remote backend: Terraform writes the state data to a remote data store, which can then be shared between all members of a team. By using a remote backend you get:

- **🔒 State Locking** - Only one apply can modify the state at a time, preventing concurrent runs from corrupting it.
- **🕰️ State Versioning** - Every change to the state is kept as a previous version, so you can recover from accidental deletion or a bad apply.
- **🔐 Server Side Encryption** - State often contains sensitive values such as passwords and keys. It is encrypted at rest using a KMS key.
- **🚫 Public Access Block** - All public access to the bucket is blocked, so the state can never be exposed by a misconfigured policy.

## 🔌 USING THE REMOTE BACKEND

Once the backend exists, point any other Terraform project at it by adding a `backend` block:

```hcl
terraform {
  backend "s3" {
    bucket       = "<state_bucket_name>"
    key          = "<project-name>/terraform.tfstate"
    region       = "<aws_region>"
    encrypt      = true
    kms_key_id   = "<kms_key_arn/kms_key_alais>"
    use_lockfile = true
  }
}
```

Then run `terraform init`. If the project already has local state, Terraform will offer to copy it to the bucket.

`use_lockfile = true` enables S3 native state locking (Terraform >= 1.10), so no DynamoDB table is required.
