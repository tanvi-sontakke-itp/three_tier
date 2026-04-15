variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "vm_username" {
  type = string
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "vmss_sku" {
  type = string
}

variable "instances" {
  type = number
}

variable "disable_password_authentication" {
  type = bool
}

variable "image_publisher" {
  type = string
}

variable "image_offer" {
  type = string
}

variable "image_sku" {
  type = string
}

variable "image_version" {
  type = string
}

variable "os_disk_caching" {
  type = string
}

variable "os_disk_storage_account_type" {
  type = string
}

variable "nic_name" {
  type = string
}

variable "ip_config_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "backend_pool_id" {
  type = string
}
