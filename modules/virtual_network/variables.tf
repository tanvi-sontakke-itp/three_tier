variable "location" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "subnet_information" {
  type = map(object({
    cidrblock = string
  }))
}

variable "address_space" {
  type = list(string)
}