variable "slb" {
  description = "The ID of the SLB"
}

variable "instances" {
  description = "List of instances ID to place in the SLB pool"
  type        = list(string)
}

variable "protocol" {
  default = "tcp"
}

variable "frontend_port" {
  default = "80"
}

variable "health_check_type" {
  default = "tcp"
}

variable "backend_port" {
  default = "80"
}

