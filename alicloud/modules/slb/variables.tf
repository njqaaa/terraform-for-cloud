variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
}

# VSwitch variables
variable "vswitch_id" {
  description = "The vswitch id used to launch load balancer."
  default     = ""
}

# Load Balancer Instance variables
variable "name" {
  description = "The name of a new load balancer."
  default     = "module-slb"
}

variable "internal" {
  description = "If true, SLB instance will be an internal SLB."
  default     = false
}

variable "internet_charge_type" {
  description = "The charge type of load balancer instance internet network."
  default     = "PayByTraffic"
}

variable "bandwidth" {
  description = "The load balancer instance bandwidth."
  default     = 10
}

variable "spec" {
  description = "The specification of the SLB instance."
  default     = ""
}

variable "instances" {
  description = "List of instances ID to place in the SLB pool"
  type        = list(string)
}

variable "protocol" {
  default = "tcp"
}

variable "frontend_port" {
  default = ""
}

variable "health_check_type" {
  default = ""
}

variable "backend_port" {
  default = ""
}

