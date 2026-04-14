// calling the resource group
module "resource_group" { // gives the local name to the module
  source = "./modules/resource_group"
}

// call the virtual network module
module "virtual_network" {
  source             = "./modules/virtual_network"
  resource_group     = module.resource_group.rg_name // output from another module
  location           = var.location
  tags               = var.tags
  subnet_information = var.subnet_information
  address_space      = var.address_space // 10.1.0.0/16
}

module "nsg" {
  source                        = "./modules/nsg"
  nsg_name                      = var.nsg_name
  location                      = var.location
  resource_group                = module.resource_group.rg_name
  tags                          = var.tags
  application_gateway_subnet_id = module.virtual_network.application_gateway_subnet_id
}

// call the application gateway module
module "application_gateway" {
  source                        = "./modules/application_gateway"
  app_gateway_name              = var.app_gateway_name
  app_gateway_public_ip         = var.app_gateway_public_ip
  location                      = var.location
  tags                          = var.tags
  resource_group                = module.resource_group.rg_name
  application_gateway_subnet_id = module.virtual_network.application_gateway_subnet_id
}


// call the vmss module
module "vmss1" {
  source          = "./modules/vmss"
  name            = var.vmss_name
  resource_group  = module.resource_group.rg_name
  location        = "East US 2"
  tags            = var.tags
  vm_username     = var.vm_username
  vm_password     = var.vm_password
  subnet_id       = module.virtual_network.backend_subnet_id
  backend_pool_id = module.application_gateway.backend_pool_id
  depends_on      = [module.virtual_network, module.application_gateway] // meta-argument to explicitly define the depencency
}

// call the nat gateway module
module "nat_gateway" {
  source             = "./modules/nat_gateway"
  nat_name           = var.nat_name
  nat_public_ip_name = var.nat_public_ip_name
  location           = var.location
  resource_group     = module.resource_group.rg_name
  tags               = var.tags
  backend_subnet_id  = module.virtual_network.backend_subnet_id
}

// call the database
module "db_server" {
  source            = "./modules/database"
  name              = var.db_name
  resource_group    = module.resource_group.rg_name
  location          = "Central US"
  dbuser            = var.dbuser
  dbpassword        = var.dbpassword
  vnet_id           = module.virtual_network.vnet_id
  backend_subnet_id = module.virtual_network.backend_subnet_id
  tags              = var.tags
  depends_on = [module.virtual_network]
}

// call public dns
module "dns" {
  source = "./modules/public_dns"

  resource_group        = module.resource_group.rg_name
  app_gateway_public_ip = module.application_gateway.public_ip
}
