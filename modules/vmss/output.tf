output "vmss_name" {
    value = azurerm_linux_virtual_machine_scale_set.backend_vmss
}

output "vmss_id" {
  value = azurerm_linux_virtual_machine_scale_set.backend_vmss.id
}