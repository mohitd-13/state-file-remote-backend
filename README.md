# STATE FILE REMOTE BACKEND

State file remote backend let you store your terraform state into an aws S3 bucket. Storing state files into remote backend helps you maintain single source of truth between your local and remote state. By using remote backend you also enable features like state versioning, locking, server-side encryption and blocking public access.

## WHY USE REMOTE BACKEND?

By default, Terraform stores state locally in a file named `terraform.tfstate`. This makes working with Terrform in a team complicated. If two team members run `terraform apply` at the same time, they ended up overwriting each other's changes. If your laptop's hard drive fails, you lose the state and Terraform no longer knows what resources it manages. Failing to share the latest state with team can result in a state that is out of sync with reality.

To solve these problems we use a remote backend, Terraform writes the state data to a remote data store, which can then be shared between all members of a team. By using remote backend 

- **State Locking** -
- **State Versioning** -
- **Server Side Encryption** -
- **Public Access Block** - 

## ARCHITECTURE OVERVIEW

The architecture is simple we create a S3 bucket with S3 native state locking enabled. We create addition resources for the bucket like state versioning, server-side encryption, blocking public access and a kms key which perform server-side encryption on state files.

## GETTING STARTED

### PREREQUISITES

**Before creating remote backend in your AWS account, you need to make sure that you have the following installed on your local machine:**

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.10
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) >= 2.x, configured with credentials (`aws configure`)

### INSTALLATION

1. Clone the repo and change directory

    ```bash
    git clone 
    ```

2. Find out your github repo sub prefix that will be used in your IAM Role trust policy subject:

    ```bash
    
3. Create terraform.tfvars file in project root:
4. Open the terraform.tfvars in your code editor:
5. Checkout the resources that will be created:
6. Run terraform apply:
## CI/CD

## CONTRIBUTION

## LICENSE
