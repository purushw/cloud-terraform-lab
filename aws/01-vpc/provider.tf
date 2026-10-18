# Use the lab's SSO profile in the selected AWS region.
provider "aws" {
  profile = "purush-lab"
  region  = var.aws_region
}
