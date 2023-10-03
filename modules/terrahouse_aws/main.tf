terraform {
  
    required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

#provider "aws" {
#  # Configuration options
#}

  resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    UserUuid        = var.user_uuid
    Environment     = "Dev"
  }
}