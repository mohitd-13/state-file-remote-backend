# STATE FILE REMOTE BACKEND

State file remote backend creates an aws S3 bucket that lets you store terraform state data. By storing Terraform state files into remote backend you can maintain single source of truth between your local and remote state. Using remote backend also enables features like state versioning, locking, server-side encryption and blocking public access.

## ARCHITECTURE OVERVIEW

The architecture is simple when a team member or a CI/CD pipeline apply new changes, the state acquires lock until the apply is in process, this prevent other team members or a CI/CD pipeline from modifying the state in the middle of an apply. Terraform refuses to proceed and reports who holds the lock and when it was acquired. Only one operation can hold the lock at a time. When the operation completes, the lock is released.

## GETTING STARTED

### PREREQUISITES

**Install the following on your local machine before creating Remote Backend:**

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.10
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) >= 2.x, configured with credentials (`aws configure`)

### INSTALLATION

1. Clone the repo, change directory and create terraform.tfvars file in the project root:

    ```bash
    git clone https://github.com/mohitd-13/state-file-remote-backend.git
    cd state-file-remote-backend
    touch terraform.tfvars
    ```
    
2. Open the terraform.tfvars file in your code editor and populate the following variables:

    ```text
    aws_region        = "<Name of the aws region where you want to create the remote backend>"
    state_bucket_name = "<Write a unique name for the S3 bucket>"
    ```

3. Initialize Terraform, validate and view the resources that will be created:

    ```bash
    terraform init
    terraform validate
    terraform plan
    ```

4. Apply Terraform configurations:

    ```bash
    terraform apply -auto-approve
    ```

## WHY USE REMOTE BACKEND?

By default, Terraform stores state locally in a file named `terraform.tfstate`. This makes working with Terrform in a team complicated. If two team members run `terraform apply` at the same time, they ended up overwriting each other's changes. If your laptop's hard drive fails, you lose the state and Terraform no longer knows what resources it manages. Failing to share the latest state with team can result in a state that is out of sync with reality.

To solve these problems we use a remote backend, Terraform writes the state data to a remote data store, which can then be shared between all members of a team. By using remote backend 

- **State Locking** -
- **State Versioning** -
- **Server Side Encryption** -
- **Public Access Block** -
