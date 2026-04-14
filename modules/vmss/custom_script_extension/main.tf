resource "azurerm_virtual_machine_scale_set_extension" "vmss-extension" {
  name                         = "install-nginx"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.backend_vmss.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.1"

  settings = jsonencode({
    fileUris = [
      "https://${azurerm_storage_account.storage_acc.name}.blob.core.windows.net/${azurerm_storage_container.scripts_container.name}/script.sh",
      "https://${azurerm_storage_account.storage_acc.name}.blob.core.windows.net/${azurerm_storage_container.scripts_container.name}/server.js"
    ]

    commandToExecute = <<EOT
#!/bin/bash

# install nginx
bash script.sh

# move server.js into a folder
mkdir -p /home/azureuser123/app
mv server.js /home/azureuser123/app/server.js

chmod 644 /home/azureuser123/app/server.js

echo "server.js deployed" > /home/azureuser123/app/log.txt
EOT
  })
}
