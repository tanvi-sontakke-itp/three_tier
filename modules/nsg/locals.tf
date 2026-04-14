locals {
  location = "East US2"
  network_security_rules = [
    {
      name                   = "AllowHTTP"
      priority               = 100
      destination_port_range = "80"
    },
    {
      name                   = "AllowHTTPS"
      priority               = 110
      destination_port_range = "443"
    },
    {
      name                   = "AllowAppGatewayHealthProbe"
      priority               = 120
      destination_port_range = "65200-65535"
    }
  ]
}
