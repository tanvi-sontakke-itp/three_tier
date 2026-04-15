resource "azurerm_linux_virtual_machine_scale_set" "backend_vmss" {

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group

  sku       = var.vmss_sku
  instances = var.instances

  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  disable_password_authentication = var.disable_password_authentication

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  network_interface {
    name    = var.nic_name
    primary = true

    ip_configuration {
      name      = var.ip_config_name
      subnet_id = var.subnet_id
      primary   = true

      // connect vmss to appln gateway
      application_gateway_backend_address_pool_ids = [
        var.backend_pool_id
      ]
    }
  }
}
