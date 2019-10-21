module "vpc" {
  source = "../../modules/vpc"

  region = var.region

  vpc_cidr        = var.vpc_cidr
  vpc_name        = var.vpc_name
  vpc_description = "已接入 Terraform"

  availability_zones  = var.availability_zones
  vswitch_name        = var.availability_zones
  vswitch_description = "已接入 Terraform"
  vswitch_cidrs       = var.vswitch_cidrs

}

