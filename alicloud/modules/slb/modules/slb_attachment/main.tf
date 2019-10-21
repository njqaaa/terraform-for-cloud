resource "alicloud_slb_attachment" "this" {
  load_balancer_id = var.slb
  instance_ids     = var.instances
}

resource "alicloud_slb_listener" "this" {
  load_balancer_id  = var.slb
  backend_port      = var.backend_port
  frontend_port     = var.frontend_port
  protocol          = var.protocol
  health_check_type = var.health_check_type
  bandwidth         = "100"
}
