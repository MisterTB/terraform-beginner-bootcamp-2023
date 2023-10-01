terraform {
  # cloud {
  #  organization = "MisterTB"
  #  workspaces {
  #    name = "terra-house-tb"
  #  }
  #}

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}