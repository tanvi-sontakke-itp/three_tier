// defines where terraform stores its state file (terraform.tfstate --> to track created resources, compare desired vs actual state, and plan changes)

terraform {
  // store state in azure storage instead of locally
  backend "azurerm" {
    resource_group_name  = "tanvi-practice-rg"
    storage_account_name = "tanvistorage123" // must exist beforehand, since backend is initialized before terraform runs its resources
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
