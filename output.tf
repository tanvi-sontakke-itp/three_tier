output "resource_group_name" {
  description = "Name of the created resource group"
  value       = module.resource_group.rg_name
}

output "vnet_id" {
  description = "Virtual Network ID"
  value       = module.virtual_network.vnet_id
}

output "backend_subnet_id" {
  description = "Backend subnet used by VMSS"
  value       = module.virtual_network.backend_subnet_id
}

output "application_gateway_public_ip" {
  description = "Public IP of the Application Gateway"
  value       = module.application_gateway.public_ip
}

output "application_url" {
  description = "Public DNS endpoint for the application"
  value       = "tanvi.threetier.tech"
}

output "database_server_name" {
  description = "PostgreSQL Flexible Server name"
  value       = module.db_server.db_server_name
}

output "database_fqdn" {
  description = "PostgreSQL server FQDN"
  value       = module.db_server.db_fqdn
}
