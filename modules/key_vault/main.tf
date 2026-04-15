data "azurerm_key_vault" "kv" {
  name = "mansikeyvault"
  resource_group_name = var.resource_group
}

data "azurerm_key_vault_certificate" "cert" {
  name         = "tanvi-app-gateway-1"
  key_vault_id = data.azurerm_key_vault.kv.id
}