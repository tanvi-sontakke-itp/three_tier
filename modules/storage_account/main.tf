resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_storage_account" "storage_acc" {
  name                     = lower("tanvistorageaccount${random_integer.suffix.result}")
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.acc_replication_type

  tags = var.tags
}

resource "azurerm_storage_container" "scripts_container" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.storage_acc.id
  container_access_type = var.container_access_type
}

resource "azurerm_storage_blob" "script_sh" {
  name                   = "script.sh"
  storage_account_name   = azurerm_storage_account.storage_acc.name
  storage_container_name = azurerm_storage_container.scripts_container.name
  type                   = var.blob_type

  source       = "${path.module}/backend/script.sh"
  content_type = "text/x-shellscript"
}

resource "azurerm_storage_blob" "server_js" {
  name                   = "server.js"
  storage_account_name   = azurerm_storage_account.storage_acc.name
  storage_container_name = azurerm_storage_container.scripts_container.name
  type                   = var.blob_type

  source       = "${path.module}/backend/server.js"
  content_type = "application/javascript"
}

resource "azurerm_storage_blob" "db_js" {
  name                   = "db.js"
  storage_account_name   = azurerm_storage_account.storage_acc.name
  storage_container_name = azurerm_storage_container.scripts_container.name
  type                   = var.blob_type

  source       = "${path.module}/backend/db.js"
  content_type = "application/javascript"
}

resource "azurerm_storage_blob" "auth_js" {
  name                   = "authMiddleware.js"
  storage_account_name   = azurerm_storage_account.storage_acc.name
  storage_container_name = azurerm_storage_container.scripts_container.name
  type                   = var.blob_type

  source       = "${path.module}/backend/authMiddleware.js"
  content_type = "application/javascript"
}
