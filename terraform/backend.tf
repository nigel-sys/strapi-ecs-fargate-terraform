terraform {
  backend "s3" {
    bucket  = "pratyush-baxla-ecs-strapi-terraform"
    key     = "strapi/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
