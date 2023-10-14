terraform {
  required_providers {
    terratowns ={
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
   cloud {
    organization = "MisterTB"
    workspaces {
      name = "terra-house-tb"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_terrahouse-tb_hosting" {
 source = "./modules/terrahouse_aws"
 user_uuid = var.teacherseat_user_uuid
 public_path = var.terrahouse-tb.public_path
 content_version = var.terrahouse-tb.content_version
}

resource "terratowns_home" "home_terrahouse-tb"{

  name = "Terrahouse TB - House of Many styles"
  description = <<DESCRIPTION
Terrahouse TB is group of elite specialists from all sides of the kingdom.
There is no father to our styles. We flow like water and adapt to our surroundings.
DESCRIPTION
  domain_name = module.home_terrahouse-tb_hosting.domain_name
  #domain_name = "34sulslzde.cloudfront.net"
  town = "gamers-grotto"
  content_version = var.terrahouse-tb.content_version  
}

module "home_terrahouse-tb1_hosting" {
 source = "./modules/terrahouse_aws"
 user_uuid = var.teacherseat_user_uuid
 public_path = var.terrahouse-tb1.public_path
 content_version = var.terrahouse-tb1.content_version

}

resource "terratowns_home" "home_terrahouse-tb1"{

  name = "All Covered with Cheese"
  description = <<DESCRIPTION
  I could eat spaghetti everyday and don't forget the parm and breadsticks.
DESCRIPTION
  domain_name = module.home_terrahouse-tb1_hosting.domain_name
  #domain_name = "34sulslzde.cloudfront.net"
  
  town = "cooker-cove"
  content_version = var.terrahouse-tb1.content_version  
}