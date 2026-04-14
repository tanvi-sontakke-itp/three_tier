variable "location" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "Owner" {
  type = string
}

variable "Practice" {
  type = string
}

variable "vm_username" {
  type = string
}

variable "vm_password" {
  type      = string
  sensitive = true
}

# variable "subnet_id" {
#   type = string
# }

# variable "vnet_id" {
#   type = string
# }

variable "dbuser" {
  description = "Database admin username"
  type        = string
}

variable "dbpassword" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "tags" {
  type = map(string)
  default = {
    "Owner"    = "tanvi.sontakke@intuitive.ai"
    "Practice" = "NetSec"
  }
}

variable "subnet_information" {
  type = map(object({
    cidrblock = string
  }))
}

variable "nsg_name" {
  type = string
}

variable "vmss_name" {
  type = string
}

variable "db_name" {
  type = string
}

variable "nat_name" {
  type = string
}

variable "nat_public_ip_name" {
  type = string
}

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_public_ip" {
  type = string
}
