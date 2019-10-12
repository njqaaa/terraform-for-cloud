provider "alicloud" {
  version              = ">=1.56.0"
  region               = var.region != "" ? var.region : null
  configuration_source = "terraform-alicloud-modules/ecs-instance"
}

// Images data source for image_id
data "alicloud_images" "default" {
  most_recent = true
  owners      = "system"
  name_regex  = var.image_name_regex
}

// Instance_types data source for instance_type
data "alicloud_instance_types" "default" {
  cpu_core_count = var.cpu_core_count
  memory_size    = var.memory_size
}

// Zones data source for availability_zone
data "alicloud_zones" "default" {
  available_disk_category = var.disk_category
  available_instance_type = data.alicloud_instance_types.default.instance_types[0].id
}

// ECS Instance Resource for Module
resource "alicloud_instance" "instances" {
  count = var.number_of_instances

  image_id          = var.image_id == "" ? data.alicloud_images.default.images[0].id : var.image_id
  availability_zone = var.vswitch_id != "" ? "" : var.availability_zone == "" ? data.alicloud_zones.default.zones[0].id : var.availability_zone
  instance_type     = var.instance_type == "" ? data.alicloud_instance_types.default.instance_types[0].id : var.instance_type
  security_groups   = length(var.group_ids) == 0 ? [alicloud_security_group.default[0].id] : var.group_ids

  instance_name = var.number_of_instances < 2 ? var.instance_name : format(
    "%s-%s",
    var.instance_name,
    format(var.number_format, count.index + 1),
  )
  host_name = var.number_of_instances < 2 ? var.host_name : format(
    "%s-%s",
    var.host_name,
    format(var.number_format, count.index + 1),
  )

  internet_charge_type       = var.internet_charge_type
  internet_max_bandwidth_out = var.internet_max_bandwidth_out

  instance_charge_type = var.instance_charge_type
  system_disk_category = var.system_category
  system_disk_size     = var.system_size

  password = var.password

  vswitch_id = var.vswitch_id == "" ? alicloud_vswitch.default[0].id : var.vswitch_id

  #  private_ip = var.number_of_instances < 2 ? var.private_ips[0] : var.private_ips[count.index]

  user_data = var.user_data

  key_name = var.key_name

  period = var.period

  tags = {
    created_by   = var.instance_tags["created_by"]
    created_from = var.instance_tags["created_from"]
  }
}

// ECS Disk Resource for Module
resource "alicloud_disk" "disks" {
  count = var.number_of_disks

  availability_zone = var.availability_zone == "" ? data.alicloud_zones.default.zones[0].id : var.availability_zone
  name = var.number_of_disks < 2 ? var.disk_name : format(
    "%s-%s",
    var.disk_name,
    format(var.number_format, count.index + 1),
  )
  category = var.disk_category
  size     = var.disk_size

  tags = {
    created_by   = var.disk_tags["created_by"]
    created_from = var.disk_tags["created_from"]
  }
}

// Attach ECS disks to instances for Module
resource "alicloud_disk_attachment" "disk_attach" {
  count       = var.number_of_instances > 0 && var.number_of_disks > 0 ? var.number_of_disks : 0
  disk_id     = alicloud_disk.disks.*.id[count.index]
  instance_id = alicloud_instance.instances.*.id[count.index % var.number_of_instances]
}

// Attach key pair to instances for Module
resource "alicloud_key_pair_attachment" "default" {
  count = var.number_of_instances > 0 && var.key_name != "" ? 1 : 0

  key_name     = var.key_name
  instance_ids = alicloud_instance.instances.*.id
}

resource "alicloud_security_group" "default" {
  count  = length(var.group_ids) > 0 ? 0 : 1
  vpc_id = alicloud_vpc.default.*.id[count.index]
}

resource "alicloud_vpc" "default" {
  count      = length(var.group_ids) > 0 ? 0 : 1
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default" {
  count             = length(var.group_ids) == 0 && var.vswitch_id == "" ? 1 : 0
  availability_zone = var.availability_zone == "" ? data.alicloud_zones.default.zones[0].id : var.availability_zone
  cidr_block        = "172.16.0.0/24"
  vpc_id            = alicloud_vpc.default.*.id[count.index]
}