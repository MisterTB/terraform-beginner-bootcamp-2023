terraform {
  required_providers {
    terratowns ={
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  # cloud {
  #  organization = "MisterTB"
  #  workspaces {
  #    name = "terra-house-tb"
  #  }
  #}

}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}
#module "terrahouse_aws" {
# source = "./modules/terrahouse_aws"
# user_uuid = var.user_uuid
# bucket_name = var.bucket_name
# index_html_filepath = var.index_html_filepath
# error_html_filepath = var.error_html_filepath
# content_version = var.content_version
# assets_path = var.assets_path
#}

resource "terratowns_home" "home"{

  name = "Terrahouse TB - House of Many styles"
  description = <<DESCRIPTION
Terrahouse TB is group of elite specialists from all sides of the kingdom.
There is no father to our styles. We flow like water and adapt to our surroundings.
DESCRIPTION
  #domain name = module.terrahouse_aws.cloudfront_url
  domain_name = "34sulslzde.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1  
}