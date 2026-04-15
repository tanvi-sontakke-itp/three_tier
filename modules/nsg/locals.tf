locals {

  application_gateway_security_rules = [
    {
      name                   = "AllowHTTP"
      priority               = 100
      destination_port_range = "80"
      source                 = "Internet"
    },
    {
      name                   = "AllowHTTPS"
      priority               = 110
      destination_port_range = "443"
      source                 = "Internet"
    },
    {
      name                   = "AllowAppGatewayInfrastructure"
      priority               = 120
      destination_port_range = "65200-65535"
      source                 = "GatewayManager"
    },
    {
      name                   = "AllowAzureLoadBalancer"
      priority               = 130
      destination_port_range = "*"
      source                 = "AzureLoadBalancer"
    }
  ]

}
