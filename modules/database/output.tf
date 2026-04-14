output "dbName" {
  value = azurerm_postgresql_flexible_server.postgresql.name

}

output "db_server_name" {
  value = azurerm_postgresql_flexible_server.postgresql.name
}

output "db_fqdn" {
  value = azurerm_postgresql_flexible_server.postgresql.fqdn
}
