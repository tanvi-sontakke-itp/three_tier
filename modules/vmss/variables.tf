variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "subnet_id" {
  type = string
  description = "subnet id for the vmss nic"
}

variable "vm_password" {
  type = string
  sensitive = true
}

variable "backend_pool_id" {
  description = "Application Gateway backend pool ID to attach VMSS to"
  type        = string
}

variable "vm_username" {
  type = string
}

variable "tags" {
  type = map(string)
}