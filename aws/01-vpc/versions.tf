# Keep Terraform and AWS provider versions compatible across lab runs.
terraform {
  required_version = "~> 1.13.0"

  # Store shared state in S3 and use its lockfile to avoid concurrent writes.
  backend "s3" {
    bucket       = "purush-cloud-terraform-state"
    key          = "aws/01-vpc/terraform.tfstate"
    region       = "eu-west-2"
    profile      = "purush-lab"
    use_lockfile = true
  }

  # Pin the official AWS provider to the supported major version.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

