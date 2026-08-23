variable "aws_region" {
  description = "AWS region for the lab"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the lab VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet configuration"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))

  default = {
    public_1 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "eu-west-2a"
    }

    public_2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "eu-west-2b"
    }
  }
}

variable "private_subnets" {
  description = "Private subnet configuration"

  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))

  default = {
    private_1 = {
      cidr_block        = "10.0.11.0/24"
      availability_zone = "eu-west-2a"
    }

    private_2 = {
      cidr_block        = "10.0.12.0/24"
      availability_zone = "eu-west-2b"
    }
  }
}