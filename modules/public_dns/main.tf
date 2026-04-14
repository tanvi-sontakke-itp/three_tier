//public dns
# data "azurerm_dns_zone" "existing_zone" {
#   name                = "threetier.tech"
#   resource_group_name = var.resource_group
# }

resource "azurerm_dns_zone" "public_dns" {
  name                = "threetier.tech"
  resource_group_name = var.resource_group
}

resource "azurerm_dns_a_record" "tanvi_a_record" {
  name                = "tanvi"
  zone_name           = azurerm_dns_zone.public_dns.name
  resource_group_name = var.resource_group
  ttl                 = 300
  records = [
    var.app_gateway_public_ip
  ]
}

