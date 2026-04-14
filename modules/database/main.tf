resource "azurerm_postgresql_flexible_server" "postgresql" {
  name                   = var.name
  resource_group_name    = var.resource_group
  location               = var.location
  administrator_login    = var.dbuser
  administrator_password = var.dbpassword

  sku_name   = "B_Standard_B1ms"
  version    = "15"
  storage_mb = 32768

  backup_retention_days         = 7
  public_network_access_enabled = false
}

//private dns zone
resource "azurerm_private_dns_zone" "postgres_dns" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group
}

resource "azurerm_private_endpoint" "postgres_private_endpoint" {
  name                = "postgres-private-endpoint" // if you're using workspaces, then the name might change per environment: name = "${var.environment}-postgres-pe"
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = var.backend_subnet_id

  private_service_connection {
    name                           = "postgres-connection"
    private_connection_resource_id = azurerm_postgresql_flexible_server.postgresql.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "postgres-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.postgres_dns.id]
  }

  depends_on = [azurerm_postgresql_flexible_server.postgresql]
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_link" {
  name                  = "postgres-vnet-link" // name = "${var.environment}-postgres-vnet-link" for different environments
  resource_group_name   = var.resource_group
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns.name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
  depends_on = [
    azurerm_private_dns_zone.postgres_dns,
    # azurerm_private_endpoint.postgres_private_endpoint
  ]
}
