resource "azurerm_linux_virtual_machine_scale_set" "backend_vmss" {

  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group
  sku                             = "Standard_B2s"
  instances                       = 2
  admin_username                  = var.vm_username
  admin_password                  = var.vm_password // use managed identity and fetch the secret at runtime inside the VM
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "backend-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      subnet_id = var.subnet_id
      primary   = true

      // connet the vmss nic to the app gateway backend pool
      application_gateway_backend_address_pool_ids = [
        var.backend_pool_id
      ]

    }
  }
}
