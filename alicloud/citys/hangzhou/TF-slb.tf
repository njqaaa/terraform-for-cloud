module "slb-test" {
  source = "../../modules/slb"

  vswitch_id = module.vpc.vswitch_id_1
  instances  = module.ecs-test.list_instance_ids

  region            = var.region
  name              = "test"
  internal          = var.internal
  spec              = var.spec
  backend_port      = var.backend_port
  frontend_port     = var.frontend_port
  protocol          = var.protocol
  health_check_type = var.health_check_type
}
