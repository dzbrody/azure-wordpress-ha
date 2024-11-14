### load_balancer.tf

resource "azurerm_public_ip" "vmss" {
  count               = 4
  name                = "pip-${element(["proleaguenetwork", "putttour", "slappoker", "str33t"], count.index)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  zones               = var.zones
  sku                 = var.pip_sku
  tags                = var.tags
}

resource "azurerm_lb" "vmss" {
  count               = 4
  name                = "lb-${element(["proleaguenetwork", "putttour", "slappoker", "str33t"], count.index)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.vmss[count.index].id
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  count          = 4
  loadbalancer_id = azurerm_lb.vmss[count.index].id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "vmss" {
  count           = 4
  loadbalancer_id = azurerm_lb.vmss[count.index].id
  name            = "running-probe"
  port            = var.application_port
}

resource "azurerm_lb_rule" "lbnatrule" {
  count                           = 4
  loadbalancer_id                = azurerm_lb.vmss[count.index].id
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = var.application_port
  backend_port                   = var.application_port
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bpepool[count.index].id]
  probe_id                       = azurerm_lb_probe.vmss[count.index].id
}