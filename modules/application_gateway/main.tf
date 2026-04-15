  resource "azurerm_public_ip" "appgw_ip" {
    name                = var.app_gateway_public_ip
    location            = var.location
    resource_group_name = var.resource_group
    allocation_method   = var.ip_alloc_method
    sku                 = var.ip_sku
  }

  // create managed identity
  resource "azurerm_user_assigned_identity" "appgw_managed_identity" {
    name                = "${var.app_gateway_name}-managed-identity"
    location            = var.location
    resource_group_name = var.resource_group
    tags                = var.tags
  }

  //assign role to managed identity
  resource "azurerm_role_assignment" "appgw_key_vault_access" {
    principal_id         = azurerm_user_assigned_identity.appgw_managed_identity.principal_id
    role_definition_name = var.role_def_name
    scope                = var.key_vault_id
  }

  resource "azurerm_application_gateway" "appgw" {
    name                = var.app_gateway_name
    location            = var.location
    resource_group_name = var.resource_group

    depends_on = [
      azurerm_role_assignment.appgw_key_vault_access
    ]

    // attach managed identity
    identity {
      type         = var.managed_identity_type
      identity_ids = [azurerm_user_assigned_identity.appgw_managed_identity.id]
    }

    sku {
      name     = var.appgw_sku_name
      tier     = var.appgw_sku_tier
      capacity = var.appgw_capacity
    }

    probe {
      name                = var.probe_name
      protocol            = "Http"
      path                = "/"
      interval            = 30
      timeout             = 30
      unhealthy_threshold = 3

      match {
        status_code = ["200-399"]
      }

      pick_host_name_from_backend_http_settings = true
    }

    gateway_ip_configuration {
      name      = var.gateway_ip_config
      subnet_id = var.application_gateway_subnet_id
    }

    frontend_ip_configuration {
      name                 = var.frontend_ip_config
      public_ip_address_id = azurerm_public_ip.appgw_ip.id
    }

    frontend_port {
      name = var.http_port_name
      port = var.http_port
    }

    frontend_port {
      name = var.https_port_name
      port = var.https_port
    }

    backend_address_pool {
      name = var.backend_pool_name
    }

    backend_http_settings {
      name                                = var.backend_http_settings_name
      cookie_based_affinity               = "Disabled"
      port                                = var.backend_port
      protocol                            = "Http"
      request_timeout                     = 30
      probe_name                          = var.probe_name
      pick_host_name_from_backend_address = true
    }

    http_listener {
      name                           = var.http_listener_name
      frontend_ip_configuration_name = var.frontend_ip_config
      frontend_port_name             = var.http_port_name
      protocol                       = "Http"
    }

    http_listener {
      name                           = var.https_listener_name
      frontend_ip_configuration_name = var.frontend_ip_config
      frontend_port_name             = var.https_port_name
      protocol                       = "Https"
      ssl_certificate_name           = var.ssl_cert_name
    }

    // redirect from http -> https
    redirect_configuration {
      name                 = var.redirect_config_name
      redirect_type        = var.redirect_type
      target_listener_name = var.redirect_target_listener_name
      include_path         = true
      include_query_string = true
    }

    // redirect routing rule
    request_routing_rule {
      name                        = var.http_redirect_rule_name
      rule_type                   = "Basic"
      http_listener_name          = var.http_listener_name
      redirect_configuration_name = var.redirect_config_name
      priority                    = var.http_priority
    }

    //https routing rule
    request_routing_rule {
      name                       = var.https_rule_name
      rule_type                  = "Basic"
      http_listener_name         = var.https_listener_name
      backend_address_pool_name  = var.backend_pool_name
      backend_http_settings_name = var.backend_http_settings_name
      priority                   = var.https_priority
    }

    ssl_certificate {
      name                = var.ssl_cert_name
      key_vault_secret_id = var.certificate_secret_id // fetch the actual cert from the key vault
    }

    // set the TLS/SSL security configuration for Application Gateway
    ssl_policy {
      policy_type = var.ssl_policy_type
      policy_name = var.ssl_policy_name
    }

    tags = var.tags
  }
