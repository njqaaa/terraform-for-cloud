provider "alicloud" {
  version              = ">=1.56.0"
  region               = var.region != "" ? var.region : null
  configuration_source = "terraform-alicloud-modules/vpc"
}

// Instance_types data source for instance_type
data "alicloud_instance_types" "default" {
  cpu_core_count = var.cpu_core_count
  memory_size    = var.memory_size
}

// Zones data source for availability_zone
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
  available_instance_type     = data.alicloud_instance_types.default.instance_types[0].id
}

// If there is not specifying vpc_id, the module will launch a new vpc
resource "alicloud_vpc" "vpc" {
  count       = var.vpc_id == "" ? 1 : 0
  name        = var.vpc_name
  cidr_block  = var.vpc_cidr
  description = var.vpc_description
}

// According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "vswitches" {
  count             = length(var.vswitch_cidrs)
  vpc_id            = var.vpc_id != "" ? var.vpc_id : alicloud_vpc.vpc[0].id
  cidr_block        = var.vswitch_cidrs[count.index]
  availability_zone = var.availability_zones[count.index] != "" ? var.availability_zones[count.index] : lookup(data.alicloud_zones.default.zones[format("%d", length(data.alicloud_zones.default.zones) < 2 ? 0 : count.index % length(data.alicloud_zones.default.zones))], "id")
  name              = var.availability_zones[count.index] != "" ? var.availability_zones[count.index] : lookup(data.alicloud_zones.default.zones[format("%d", length(data.alicloud_zones.default.zones) < 2 ? 0 : count.index % length(data.alicloud_zones.default.zones))], "id")
  description       = var.vswitch_description
}

// According to the destination cidr block to launch a new route entry
resource "alicloud_route_entry" "route_entry" {
  count                 = length(var.destination_cidrs)
  route_table_id        = var.route_table_id != "" ? var.route_table_id : var.vpc_id == "" ? alicloud_vpc.vpc[0].route_table_id : ""
  destination_cidrblock = var.destination_cidrs[count.index]
  nexthop_type          = "Instance"
  nexthop_id            = var.nexthop_ids[count.index]
}
