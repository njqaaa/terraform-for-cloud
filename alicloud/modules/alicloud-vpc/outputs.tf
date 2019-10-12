// Output the IDs of the ECS instances created
output "vpc_id" {
  value = var.vpc_id == "" ? join(",", alicloud_vpc.vpc.*.id) : var.vpc_id
}

output "vswitch_ids" {
  value = join(",", alicloud_vswitch.vswitches.*.id)
}

output "vswitch_id_0" {
  value = alicloud_vswitch.vswitches.0.id
}

output "vswitch_id_1" {
  value = alicloud_vswitch.vswitches.1.id
}

output "vswitch_id_2" {
  value = alicloud_vswitch.vswitches.2.id
}
output "availability_zones" {
  value = join(",", alicloud_vswitch.vswitches.*.availability_zone)
}

output "router_id" {
  value = join(",", alicloud_route_entry.route_entry.*.router_id)
}

output "route_table_id" {
  value = join(",", alicloud_route_entry.route_entry.*.route_table_id)
}
