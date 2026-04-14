output "vnet1" {
  value = azurerm_virtual_network.vnet1.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet1.id
}

output "application_gateway_subnet_id" {
  value = azurerm_subnet.subnets["application-gateway-subnet"].id
}

output "backend_subnet_id" {
  value = azurerm_subnet.subnets["backend-subnet"].id
}
