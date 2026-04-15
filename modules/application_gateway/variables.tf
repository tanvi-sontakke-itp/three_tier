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

variable "key_vault_id" {
  type = string
}


variable "ip_alloc_method" {
  type = string
}

variable "ip_sku" {
  type = string
}

variable "certificate_secret_id" {
  type = string
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

variable "backend_pool_name" {
  type = string
}

variable "http_port" {
  type    = number
  default = 80
}

variable "https_port" {
  type    = number
  default = 443
}

variable "probe_name" {
  type    = string
  default = "http-probe"
}

variable "redirect_target_listener_name" {
  type = string
}

variable "backend_port" {
  type = number
}

variable "appgw_capacity" {
  type = number
}

variable "http_port_name" {
  type    = string
  default = "http-port"
}

variable "https_port_name" {
  type    = string
  default = "https-port"
}

variable "ssl_cert_name" {
  type = string
}

variable "http_listener_name" {
  type = string
}

variable "https_listener_name" {
  type = string
}

variable "redirect_config_name" {
  type = string
}

variable "redirect_type" {
  type = string
}

variable "http_redirect_rule_name" {
  type = string
}

variable "https_rule_name" {
  type = string
}

variable "http_priority" {
  type = number
}

variable "https_priority" {
  type = number
}

variable "backend_http_settings_name" {
  type    = string
  default = "backend-http"
}

variable "ssl_policy_type" {
  type    = string
  default = "Predefined"
}

variable "ssl_policy_name" {
  type    = string
  default = "AppGwSslPolicy20220101S"
}