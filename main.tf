// calling the resource group
module "resource_group" { // gives the local name to the module
  source = "./modules/resource_group"
}

// call the key vault module
module "key_vault" {
  source = "./modules/key_vault"
  //resource_group = module.resource_group.rg_name
  resource_group = var.diff_kv_rg
}

// call the virtual network module
module "virtual_network" {
  source                   = "./modules/virtual_network"
  virtual_network_name = var.virtual_network_name
  resource_group           = module.resource_group.rg_name // output from another module
  location                 = var.location
  tags                     = var.tags
  subnet_information       = var.subnet_information
  address_space            = var.address_space // 10.1.0.0/16
}

module "nsg" {
  source                        = "./modules/nsg"
  location                      = var.location
  resource_group                = module.resource_group.rg_name
  tags                          = var.tags
  application_gateway_subnet_id = module.virtual_network.application_gateway_subnet_id
  backend_subnet_id             = module.virtual_network.backend_subnet_id
  appgw_nsg_name                = var.appgw_nsg_name
  vmss_nsg_name                 = var.vmss_nsg_name
  db_nsg_name                   = var.db_nsg_name
  appgw_subnet_cidr             = var.appgw_subnet_cidr

}

// call the application gateway module
module "application_gateway" {
  source = "./modules/application_gateway"

  app_gateway_name              = var.app_gateway_name
  app_gateway_public_ip         = var.app_gateway_public_ip
  location                      = var.location
  tags                          = var.tags
  resource_group                = module.resource_group.rg_name
  application_gateway_subnet_id = module.virtual_network.application_gateway_subnet_id
  probe_name                    = var.probe_name

  ip_alloc_method = var.ip_alloc_method
  ip_sku          = var.ip_sku

  key_vault_id          = module.key_vault.key_vault_id
  certificate_secret_id = module.key_vault.key_vault_certificate_secret_id

  role_def_name         = var.role_def_name
  managed_identity_type = var.managed_identity_type

  appgw_sku_name = var.appgw_sku_name
  appgw_sku_tier = var.appgw_sku_tier
  appgw_capacity = var.appgw_capacity

  gateway_ip_config  = var.gateway_ip_config
  frontend_ip_config = var.frontend_ip_config

  backend_pool_name          = var.backend_pool_name
  backend_http_settings_name = var.backend_http_settings_name
  backend_port               = var.backend_port

  http_listener_name  = var.http_listener_name
  https_listener_name = var.https_listener_name

  http_port_name  = var.http_port_name
  https_port_name = var.https_port_name
  http_port       = var.http_port
  https_port      = var.https_port

  ssl_cert_name = var.ssl_cert_name

  redirect_config_name          = var.redirect_config_name
  redirect_type                 = var.redirect_type
  redirect_target_listener_name = var.redirect_target_listener_name

  http_redirect_rule_name = var.http_redirect_rule_name
  https_rule_name         = var.https_rule_name

  http_priority  = var.http_priority
  https_priority = var.https_priority

  ssl_policy_name = var.ssl_policy_name
  ssl_policy_type = var.ssl_policy_type
}


// call the vmss module
module "vmss1" {
  source = "./modules/vmss"

  name           = var.vmss_name
  resource_group = module.resource_group.rg_name
  location       = var.location

  vm_username = var.vm_username
  vm_password = var.vm_password

  subnet_id       = module.virtual_network.backend_subnet_id
  backend_pool_id = module.application_gateway.backend_pool_id

  vmss_sku  = var.vmss_sku
  instances = var.instances

  disable_password_authentication = var.disable_password_authentication

  image_publisher = var.image_publisher
  image_offer     = var.image_offer
  image_sku       = var.image_sku
  image_version   = var.image_version

  os_disk_caching              = var.os_disk_caching
  os_disk_storage_account_type = var.os_disk_storage_account_type

  nic_name       = var.nic_name
  ip_config_name = var.ip_config_name

  depends_on = [
    module.virtual_network,
    module.application_gateway
  ]
}

// call the nat gateway module
module "nat_gateway" {
  source             = "./modules/nat_gateway"
  nat_name           = var.nat_name
  nat_public_ip_name = var.nat_public_ip_name
  location           = var.location
  resource_group     = module.resource_group.rg_name
  tags               = var.tags
  backend_subnet_id  = module.virtual_network.backend_subnet_id
  nat_alloc_method   = var.nat_alloc_method
  nat_sku            = var.nat_sku
}

// call the database
module "db_server" {
  source = "./modules/database"

  name           = var.db_name
  resource_group = module.resource_group.rg_name
  location       = var.db_location

  dbuser     = var.dbuser
  dbpassword = var.dbpassword

  vnet_id           = module.virtual_network.vnet_id
  backend_subnet_id = module.virtual_network.backend_subnet_id
  sku_name          = var.db_sku_name

  private_endpoint_name       = var.db_private_endpoint_name
  private_connection_name     = var.db_private_connection_name
  private_dns_zone_group_name = var.db_private_dns_zone_group_name
  vnet_link_name              = var.db_vnet_link_name

  tags = var.tags

  depends_on = [
    module.virtual_network
  ]
}

// call public dns
module "dns" {
  source = "./modules/public_dns"

  resource_group        = module.resource_group.rg_name
  app_gateway_public_ip = module.application_gateway.public_ip
  public_dns_zone_name  = var.public_dns_zone_name
  A_record_name         = var.A_record_name
}

// call the storage module
module "storageacc" {
  source                = "./modules/storage_account"
  location              = var.location
  resource_group        = module.resource_group.rg_name
  blob_type             = var.blob_type
  acc_replication_type  = var.acc_replication_type
  container_name        = var.container_name
  container_access_type = var.container_access_type
  account_tier          = var.account_tier
  tags                  = var.tags

}
