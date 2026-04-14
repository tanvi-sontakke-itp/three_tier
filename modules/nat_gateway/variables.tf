variable "nat_public_ip_name" {
  type = string
}

variable "location" {
  type = string
}

variable "nat_name" {
  type = string
}

variable "backend_subnet_id" {
  type = string
}

variable "resource_group" {
  type = string
}
# var.backend_subnet_id
#       =
# module.virtual_network.backend_subnet_id

variable "tags" {
  type = map(string)
}