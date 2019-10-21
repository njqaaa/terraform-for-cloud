module "dns-hfjy_com" {
  source = "../modules/dns"

  domain_name = "hfjy.com"
  record_list = var.record_list
}

module "dns-hfjystudy_com" {
  source = "../modules/dns"

  domain_name = "hfjystudy.com"
  record_list = var.record_list
}

module "dns-hfjy_top" {
  source = "../modules/dns"

  domain_name = "hfjy.top"
  record_list = var.record_list
}

module "dns-hfjy123_com" {
  source = "../modules/dns"

  domain_name = "hfjy123.com"
  record_list = var.record_list
}
