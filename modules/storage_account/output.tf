output "storage_account_name" {
  value = azurerm_storage_account.storage_acc.name
}

output "container_name" {
  value = azurerm_storage_container.scripts_container.name
}

output "scripts_container_url" {
  value = "https://${azurerm_storage_account.storage_acc.name}.blob.core.windows.net/${azurerm_storage_container.scripts_container.name}"
}
