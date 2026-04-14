variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "dbuser" {
  type = string
}

variable "dbpassword" {
  type = string
  sensitive = true
}

variable "backend_subnet_id" {
  description = "Subnet ID for the private endpoint" // in my architecture, it is the same as the vmss
  type        = string
}

variable "vnet_id" {
  type = string
}

variable "tags" {
  type = map(string)
}