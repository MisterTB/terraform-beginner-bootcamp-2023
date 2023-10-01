terraform {
  # cloud {
  #  organization = "MisterTB"
  #  workspaces {
  #    name = "terra-house-tb"
  #  }
  #}

  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
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