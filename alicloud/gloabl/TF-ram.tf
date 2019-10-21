module "ram-test" {
  source = "../../modules/ram"

  name                  = var.ram_name
  secret_file           = var.ram_name
  create_ram_access_key = true
}

module "ram-test1" {
  source = "../../modules/ram"

  name                  = var.ram_name
  secret_file           = var.ram_name
  create_ram_access_key = true
}
