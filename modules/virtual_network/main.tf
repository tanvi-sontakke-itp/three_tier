resource "azurerm_virtual_network" "vnet1" {
  //name                = lower(local.virtual_network_name) // terraform uses local
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = var.address_space // 10.1.0.0/16

  tags = var.tags
}

// changed: added for_each
resource "azurerm_subnet" "subnets" {
  for_each             = var.subnet_information
  name                 = each.key // access the name via the key
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [each.value.cidrblock]
}
