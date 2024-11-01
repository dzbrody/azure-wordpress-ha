resource "azurerm_subnet" "subnet" {
  name                 = "snt-${var.name}"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = var.service_endpoints

}