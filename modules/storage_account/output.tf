output "storage_account_name" {
  value = azurerm_storage_account.storage_acc.name
}

output "container_name" {
  value = azurerm_storage_container.scripts_container.name
}

output "script_url" {
  value = azurerm_storage_blob.blob.url
}