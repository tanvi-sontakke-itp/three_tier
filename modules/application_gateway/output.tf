output "app-gateway-name" {
  value = azurerm_application_gateway.appgw.name
}

output "public_ip" {
  value = azurerm_public_ip.appgw_ip.ip_address
}

output "backend_pool_id" {
  value = one(azurerm_application_gateway.appgw.backend_address_pool).id
}

# output "backend_pool_name" {
#   value = azurerm_application_gateway.appgw.backend_address_pool[0].name
# }