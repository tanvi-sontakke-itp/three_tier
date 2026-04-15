variable "location" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "application_gateway_subnet_id" {
  type = string
}

variable "backend_subnet_id" {
  type = string
}

variable "appgw_nsg_name" {
  type = string
}

variable "vmss_nsg_name" {
  type = string
}

variable "db_nsg_name" {
  type = string
}

variable "appgw_subnet_cidr" {
  type = string
}