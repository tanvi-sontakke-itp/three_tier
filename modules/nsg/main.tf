resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group

  dynamic "security_rule" {
    for_each = local.network_security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "assoc1" {
  subnet_id                 = var.application_gateway_subnet_id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}