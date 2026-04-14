resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_storage_account" "storage_acc" {
  name = lower("tanvistorageaccount${random_integer.suffix.result}")

  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "scripts_container" {
  name                  = "scripts"
  storage_account_id    = azurerm_storage_account.storage_acc.id
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "blob" {
  name                   = "script.sh"
  storage_account_name   = azurerm_storage_account.storage_acc.name
  storage_container_name = azurerm_storage_container.scripts_container.name

  type         = "Block"
  source       = "${path.module}/script.sh"
  content_type = "text/x-shellscript" // MIME type of the file. making it easier to download via browser
}


resource "azurerm_storage_blob" "blob_server_js" {
  name                   = "server.js"
  storage_account_name   = azurerm_storage_account.storage_acc.name
  storage_container_name = azurerm_storage_container.scripts_container.name

  type         = "Block"
  source       = "${path.module}/server.js"
  content_type = "application/javascript"
}
