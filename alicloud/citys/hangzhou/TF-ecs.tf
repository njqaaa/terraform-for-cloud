module "ecs-test" {
  source = "../../modules/ecs-instance"

  vswitch_id        = module.vpc.vswitch_id_0
  availability_zone = module.vpc.availability_zones
  group_ids         = [module.sg-base.security_group_id, module.sg-test.security_group_id, module.sg-test1.security_group_id]

  region                     = var.region
  number_of_instances        = var.number_of_instances
  system_category            = var.system_category
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  host_name                  = var.host_name
  instance_name              = var.host_name
  instance_type              = var.instance_type
  system_size                = var.system_size
  image_name_regex           = var.image_name_regex
  instance_charge_type       = var.instance_charge_type
  private_ips                = var.private_ips
  password                   = "MTQ4MjgyMzk0aWpF"
}



