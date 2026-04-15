# Application Gateway NSG
resource "azurerm_network_security_group" "appgw_nsg" {
  name                = var.appgw_nsg_name
  location            = var.location
  resource_group_name = var.resource_group

  dynamic "security_rule" {
    for_each = local.application_gateway_security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source
      destination_address_prefix = "*"
    }
  }

  tags = var.tags
}

// backend nsg
resource "azurerm_network_security_group" "backend_nsg" {
  name                = "backend-nsg"
  location            = var.location
  resource_group_name = var.resource_group

  //Application Gateway → VMSS
  security_rule {
    name                       = "AllowAppGatewayToVMSS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = var.appgw_subnet_cidr
    source_port_range          = "*"
    destination_port_range     = "3000"
    destination_address_prefix = "VirtualNetwork"
  }

  //Backend → PostgreSQL
  security_rule {
    name                       = "AllowBackendToPostgres"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "VirtualNetwork"
    source_port_range          = "*"
    destination_port_range     = "5432"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}


//NSG Association for Application Gateway Subnet
resource "azurerm_subnet_network_security_group_association" "appgw_assoc" {
  subnet_id                 = var.application_gateway_subnet_id
  network_security_group_id = azurerm_network_security_group.appgw_nsg.id
}


//NSG Association for Backend Subnet
resource "azurerm_subnet_network_security_group_association" "backend_assoc" {
  subnet_id                 = var.backend_subnet_id
  network_security_group_id = azurerm_network_security_group.backend_nsg.id
}