variable "record_list" {
  description = "Dns record list"
  type = list(object({
    host_record = string
    type        = string
    ttl         = number
    value       = string
    priority    = number
    routing     = string
  }))
}

variable "domain_name" {
  description = "Dns record parrent domain name"
}

