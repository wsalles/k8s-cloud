terraform {
  required_version = "v0.15.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.40.0"
    }
  }

  //  backend "s3" {}
}
