module "sg-base" {
  source  = "alibaba/security-group/alicloud"
  version = "1.4.0"

  vpc_id            = module.vpc.vpc_id
  group_name        = "base"
  region            = var.region
  group_description = "已接入 Terraform"
  rule_directions   = var.rule_directions
  ip_protocols      = var.ip_protocols
  policies          = var.policies
  port_ranges       = var.port_ranges
  priorities        = var.priorities
  cidr_ips          = var.cidr_ips
}

module "sg-test" {
  source  = "alibaba/security-group/alicloud"
  version = "1.4.0"

  vpc_id            = module.vpc.vpc_id
  group_name        = "test"
  region            = var.region
  group_description = "已接入 Terraform"
  rule_directions   = var.rule_directions
  ip_protocols      = var.ip_protocols
  policies          = var.policies
  port_ranges       = var.port_ranges
  priorities        = var.priorities
  cidr_ips          = var.cidr_ips
}

module "sg-test1" {
  source  = "alibaba/security-group/alicloud"
  version = "1.4.0"

  vpc_id            = module.vpc.vpc_id
  group_name        = "test1"
  region            = var.region
  group_description = "已接入 Terraform"
  rule_directions   = var.rule_directions
  ip_protocols      = var.ip_protocols
  policies          = var.policies
  port_ranges       = var.port_ranges
  priorities        = var.priorities
  cidr_ips          = var.cidr_ips
}
