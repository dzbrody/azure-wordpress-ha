resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.name}"
  location            = var.region
  resource_group_name = var.resource_group
  dynamic "security_rule" {
    for_each = var.security_rules
    iterator = item
    content {
      name                       = item.value.name
      priority                   = item.value.priority
      direction                  = item.value.direction
      access                     = item.value.access
      protocol                   = item.value.protocol
      source_port_range          = item.value.source_port_range
      destination_port_range     = item.value.destination_port_range
      source_address_prefix      = item.value.source_address_prefix
      destination_address_prefix = item.value.destination_address_prefix
    }
  }

  tags  = var.tags
  count = length(var.security_rules) > 0 ? 1 : 0

}
