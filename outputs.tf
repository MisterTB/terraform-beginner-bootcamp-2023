output "bucket_name" {
  description = "Bucket Name for SWA Hosting"
  value = module.home_terrahouse-tb_hosting
}

output "s3_website_endpoint" {
    description = "S3 static website hosting endpoint"
    value = module.home_terrahouse-tb_hosting
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain"
  value = module.home_terrahouse-tb_hosting.domain_name
}