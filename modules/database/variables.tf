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

variable "sku_name" {
  type = string
}

variable "postgres_version" {
  type    = string
  default = "15"
}

variable "storage_mb" {
  type    = number
  default = 32768
}

variable "backup_retention_days" {
  type    = number
  default = 7
}

variable "private_dns_zone_name" {
  type    = string
  default = "privatelink.postgres.database.azure.com"
}

variable "private_endpoint_name" {
  type = string
}

variable "private_connection_name" {
  type = string
}

variable "subresource_names" {
  type    = list(string)
  default = ["postgresqlServer"]
}

variable "private_dns_zone_group_name" {
  type = string
}

variable "vnet_link_name" {
  type = string
}