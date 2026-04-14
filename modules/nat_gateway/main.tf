resource "azurerm_public_ip" "nat_public_ip" {
  name                = var.nat_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = var.nat_name
  location                = var.location
  resource_group_name     = var.resource_group
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
}

resource "azurerm_nat_gateway_public_ip_association" "nat_ip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_public_ip.id
}

# Associate NAT Gateway with backend subnet
resource "azurerm_subnet_nat_gateway_association" "backend_nat_assoc" {
  subnet_id      = var.backend_subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}
