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

variable "ip_alloc_method" {
  type    = string
  default = "Static"
}

variable "ip_sku" {
  type    = string
  default = "Standard"
}

variable "role_def_name" {
  type = string
}

variable "managed_identity_type" {
  type = string
}

variable "appgw_sku_name" {
  type = string
}

variable "appgw_sku_tier" {
  type = string
}

variable "gateway_ip_config" {
  type = string
}

variable "frontend_ip_config" {
  type = string
}

variable "appgw_capacity" {
  type    = number
  default = 2
}

variable "backend_pool_name" {
  type    = string
  default = "backend-pool"
}

variable "backend_http_settings_name" {
  type    = string
  default = "backend-http"
}

variable "backend_port" {
  type    = number
  default = 3000
}

variable "http_listener_name" {
  type    = string
  default = "http-listener"
}

variable "https_listener_name" {
  type    = string
  default = "https-listener"
}

variable "http_port_name" {
  type    = string
  default = "http-port"
}

variable "https_port_name" {
  type    = string
  default = "https-port"
}

variable "http_port" {
  type    = number
  default = 80
}

variable "https_port" {
  type    = number
  default = 443
}

variable "ssl_cert_name" {
  type    = string
  default = "app-gateway-cert"
}

variable "redirect_config_name" {
  type    = string
  default = "http-to-https-redirect"
}

variable "redirect_type" {
  type    = string
  default = "Permanent"
}

variable "redirect_target_listener_name" {
  type    = string
  default = "https-listener"
}

variable "http_redirect_rule_name" {
  type    = string
  default = "http-redirect-rule"
}

variable "https_rule_name" {
  type    = string
  default = "https-rule"
}

variable "http_priority" {
  type    = number
  default = 90
}

variable "https_priority" {
  type    = number
  default = 100
}


variable "ssl_policy_type" {
  type    = string
  default = "Predefined"
}

variable "ssl_policy_name" {
  type    = string
  default = "AppGwSslPolicy20220101S"
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

variable "db_location" {
  type = string
}


variable "db_sku_name" {
  type = string
}

variable "db_private_endpoint_name" {
  type = string
}

variable "db_private_connection_name" {
  type = string
}

variable "db_private_dns_zone_group_name" {
  type = string
}

variable "db_vnet_link_name" {
  type = string
}

variable "nat_alloc_method" {
  type = string
}

variable "nat_sku" {
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

variable "public_dns_zone_name" {
  type = string
}

variable "A_record_name" {
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

variable "appgw_subnet_cidr" {
  type = string
}

variable "diff_kv_rg" {
  type = string
}

variable "probe_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}