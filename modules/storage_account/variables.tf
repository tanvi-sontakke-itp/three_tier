
variable "tags" {
  type = map(string)
}

variable "resource_group" {
  type = string
}
variable "location" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "acc_replication_type" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_access_type" {
  type = string
}

variable "blob_type" {
  type = string
}