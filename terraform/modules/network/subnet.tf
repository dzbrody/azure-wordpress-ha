resource "azurerm_subnet" "vm_subnet" {
  name                 = "vm-subnet-${var.name}"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "mysql_subnet" {
  name                 = "mysql-subnet-${var.name}"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = var.service_endpoints
}

resource "azurerm_subnet" "storage_subnet" {
  name                 = "storage-subnet-${var.name}"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
  service_endpoints    = var.service_endpoints
}
