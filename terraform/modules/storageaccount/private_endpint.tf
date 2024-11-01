# #Criação do enpoint privado
resource "azurerm_private_endpoint" "private_endpoint" {

  name                = "${var.storage_account_name}-private_endpoint-${var.subresource_names_private_endpoint[count.index]}"
  location            = var.region
  resource_group_name = var.resource_group
  subnet_id           = var.subnet_id_private_endpoint

  private_service_connection {
    name                           = "service-connection-${var.storage_account_name}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    subresource_names              = [var.subresource_names_private_endpoint[count.index]]
  }
  dynamic "private_dns_zone_group" {
    for_each = var.name_private_link_ids != [] ? [1] : []
    content {
      name                 = "private_dns_zone_group-${var.storage_account_name}"
      private_dns_zone_ids = var.name_private_link_ids
    }
  }



  tags = var.tags

  count = var.subnet_id_private_endpoint != null ? length(var.subresource_names_private_endpoint) : 0
}