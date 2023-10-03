terraform {
  # cloud {
  #  organization = "MisterTB"
  #  workspaces {
  #    name = "terra-house-tb"
  #  }
  #}

}

module "terrahouse_aws" {
 source = "./modules/terrahouse_aws"
 user_uuid = var.user_uuid
 bucket_name = var.bucket_name 
}