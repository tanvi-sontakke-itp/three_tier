resource "azurerm_public_ip" "appgw_ip" {
  name                = var.app_gateway_public_ip
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.app_gateway_name
  location            = var.location
  resource_group_name = var.resource_group
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  probe {
    name                                      = "http-probe"
    protocol                                  = "Http"
    path                                      = "/"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
  }

  gateway_ip_configuration {
    name      = "application-gateway-ipcfg"
    subnet_id = var.application_gateway_subnet_id
  }

  frontend_ip_configuration {
    name                 = "application-gateway-frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw_ip.id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  backend_address_pool {
    name = "backend-pool"
  }

  backend_http_settings {
    name                                = "backend-http"
    cookie_based_affinity               = "Disabled"
    port                                = 3000 // since the server listens on port 3000
    protocol                            = "Http"
    request_timeout                     = 30
    probe_name                          = "http-probe"
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "application-gateway-frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "backend-http"
    priority                   = 100
  }
  
  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401S"
  }
  tags = var.tags
}
