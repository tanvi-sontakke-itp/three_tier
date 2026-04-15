output "key_vault_certificate_secret_id" {
  value       = data.azurerm_key_vault_certificate.cert.secret_id
  description = "Secret ID of the Key Vault certificate used by Application Gateway"
}

output "key_vault_id" {
  value = data.azurerm_key_vault.kv.id
}