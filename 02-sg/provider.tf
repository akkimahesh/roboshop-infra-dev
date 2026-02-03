terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }

#  backend "s3" {
#     bucket = "vcube138-2026-aws"
#     key    = "infra-sg"
#     region = "us-east-1"
#     dynamodb_table = "terraform-lock-table"
#   }
}

provider "aws" {
  region = "us-east-1"
}
