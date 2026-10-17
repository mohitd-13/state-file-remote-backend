# 🌐 REMOTE BACKEND

This guide explains why a remote backend is worth using and how to connect your Terraform projects to the one created by [State File Remote Backend](../README.md).

## ❓ Why Use Remote Backend?

By default, Terraform stores state locally in a file named `terraform.tfstate`. This makes working with Terraform in a team complicated. If two team members run `terraform apply` at the same time, they end up overwriting each other's changes. If your laptop's hard drive fails, you lose the state and Terraform no longer knows what resources it manages. Failing to share the latest state with the team can result in a state that is out of sync with reality.

To solve these problems we use a remote backend: Terraform writes the state data to a remote data store, which can then be shared between all members of a team. By using a remote backend you get:

- **🔒 State Locking** - Only one apply can modify the state at a time, preventing concurrent runs from corrupting it.
- **🕰️ State Versioning** - Every change to the state is kept as a previous version, so you can recover from accidental deletion or a bad apply.
- **🔐 Server Side Encryption** - State often contains sensitive values such as passwords and keys. It is encrypted at rest using a KMS key.
- **🚫 Public Access Block** - All public access to the bucket is blocked, so a misconfigured bucket policy or ACL cannot expose the state.

## 🔌 Using the Remote Backend

Once the backend exists, point any other Terraform project at it by adding a `backend` block. Get the bucket name and key alias from the backend project's outputs (`terraform output`):

```hcl
terraform {
  backend "s3" {
    bucket       = "<state_bucket_name>"
    key          = "<project-name>/terraform.tfstate"
    region       = "<aws_region>"
    encrypt      = true
    kms_key_id   = "<kms_key_alias>"
    use_lockfile = true
  }
}
```

Then run `terraform init`. If the project already has local state, Terraform will offer to copy it to the bucket.

`use_lockfile = true` enables S3 native state locking (Terraform >= 1.10), so no DynamoDB table is required. Use a unique `key` for every project so their states never collide.

## 🩺 Troubleshooting

| Problem | Likely cause and fix |
| --- | --- |
| `BucketAlreadyExists` | Bucket names are global. Choose a different `state_bucket_name`. |
| `Error acquiring the state lock` | Another run holds the lock. Wait for it to finish, or use `terraform force-unlock <LOCK_ID>` only if you are sure no run is active. |
| `Unsupported argument: use_lockfile` | Terraform is older than 1.10. Upgrade Terraform. |
| `Instance cannot be destroyed` | `prevent_destroy` is working as intended. See [Destroying the Backend](../README.md#-destroying-the-backend). |
