resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.name}"
  address_space       = ["10.0.0.0/16"]
  location            = var.region
  resource_group_name = var.resource_group
}