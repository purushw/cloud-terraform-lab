terraform {
  required_version = "~> 1.13.0"

  backend "s3" {
    bucket       = "purush-cloud-terraform-state"
    key          = "aws/01-vpc/terraform.tfstate"
    region       = "eu-west-2"
    profile      = "purush-lab"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

