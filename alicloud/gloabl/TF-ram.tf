module "ram-test" {
  source  = "terraform-alicloud-modules/ram/alicloud"
  version = "1.1.0"

  name                  = var.ram_name
  secret_file           = var.ram_name
  create_ram_access_key = true
}

module "ram-test1" {
  source  = "terraform-alicloud-modules/ram/alicloud"
  version = "1.1.0"

  name                  = var.ram_name
  secret_file           = var.ram_name
  create_ram_access_key = true
}
