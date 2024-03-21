terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }

  backend "s3" {
    profile = "TerraformYnov"
    bucket = "s3bucketynovb3"
    key = "tools-renaud"
    region = "eu-west-3"
  }
}

provider "aws" {
  profile = "TerraformYnov"
  region = "eu-west-3"
  assume_role {
    role_arn = "arn:aws:iam::381492166046:role/terraform_full"
  }
}



