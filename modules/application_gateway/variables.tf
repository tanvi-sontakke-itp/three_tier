variable "location" {
  type = string
}

variable "application_gateway_subnet_id" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "app_gateway_public_ip" {
  type = string
}

variable "app_gateway_name" {
  type = string
}