provider "alicloud" {
  version              = ">=1.56.0"
  region               = var.region != "" ? var.region : null
  configuration_source = "terraform-alicloud-modules/slb"
}

######
# SLB Instance
######
module "slb" {
  source = "./modules/slb"

  name = var.name

  vswitch_id = var.vswitch_id
  internal   = var.internal

  internet_charge_type = var.internet_charge_type
  bandwidth            = var.bandwidth

  spec = var.spec
}

#################
# SLB attachment
#################
module "slb_attachment" {
  source = "./modules/slb_attachment"

  slb               = module.slb.slb_id
  instances         = var.instances
  backend_port      = var.backend_port
  frontend_port     = var.frontend_port
  protocol          = var.protocol
  health_check_type = var.health_check_type
}

