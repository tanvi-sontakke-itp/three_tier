resource "azurerm_postgresql_flexible_server" "postgresql" {
  name                   = var.name
  resource_group_name    = var.resource_group
  location               = var.location
  administrator_login    = var.dbuser
  administrator_password = var.dbpassword

  sku_name   = var.sku_name
  version    = var.postgres_version
  storage_mb = var.storage_mb

  backup_retention_days         = var.backup_retention_days
  //public_network_access_enabled = false
  public_network_access_enabled = true
  
  zone                          = "1"
  # high_availability {
  #   mode = "ZoneRedundant"
  # }

}

// db firewall rule
resource "azurerm_postgresql_flexible_server_firewall_rule" "deny_all" {
  name             = "deny-all"
  server_id        = azurerm_postgresql_flexible_server.postgresql.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}


// public dns zone
resource "azurerm_private_dns_zone" "postgres_dns" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group
}

//private endpoint
resource "azurerm_private_endpoint" "postgres_private_endpoint" {
  name                = var.private_endpoint_name // if you're using workspaces, then the name might change per environment: name = "${var.environment}-postgres-pe"
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = var.backend_subnet_id

  private_service_connection {
    name                           = var.private_connection_name
    private_connection_resource_id = azurerm_postgresql_flexible_server.postgresql.id
    subresource_names              = var.subresource_names
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_group_name
    private_dns_zone_ids = [azurerm_private_dns_zone.postgres_dns.id]
  }

  depends_on = [azurerm_postgresql_flexible_server.postgresql]
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_link" {
  name                  = var.vnet_link_name
  resource_group_name   = var.resource_group
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns.name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
}
