resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
  name                         = var.resource_mysql_name
  location                     = var.region
  resource_group_name          = var.resource_group
  sku_name                     = var.database_sku
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup
  administrator_login          = var.database_mysql_admin_username
  administrator_password       = "Awvn==615@t0r0nt0"
  version                      = var.database_mysql_version
  delegated_subnet_id          = var.subnet_id != "" ? var.subnet_id : null
  private_dns_zone_id          = var.private_dns_zone_id != "" ? var.private_dns_zone_id : null
  tags                         = var.tags
  zone                         = var.mysql_zone
  storage {
    auto_grow_enabled = var.auto_grow
    iops              = var.iops
    size_gb           = var.size_gb
  }

  dynamic "high_availability" {
    for_each = var.high_availability_enabled == true ? ["1"] : []
    content {
      mode = var.ha_mode
    }
  }

  lifecycle {
    ignore_changes = [
      zone,
    ]
  }
}

resource "azurerm_mysql_flexible_server" "mysql_flexible_server_replica" {
  name                  = "${var.resource_mysql_name}-replica"
  create_mode           = "Replica"
  location              = var.region
  resource_group_name   = var.resource_group
  sku_name              = var.replica_database_sku != "" ? var.replica_database_sku : var.database_sku #replica_database_sku  must be >= var.database_sku
  backup_retention_days = var.backup_retention_days
  version               = var.database_mysql_version
  delegated_subnet_id   = var.subnet_id != "" ? var.subnet_id : null
  private_dns_zone_id   = var.private_dns_zone_id != "" ? var.private_dns_zone_id : null
  source_server_id      = azurerm_mysql_flexible_server.mysql_flexible_server.id
  zone                  = var.mysql_replica_zone
  tags                  = var.tags
  count                 = var.create_replica == true ? 1 : 0

  storage {
    auto_grow_enabled = var.auto_grow
    iops              = var.iops
    size_gb           = var.size_gb
  }
  lifecycle {
    ignore_changes = [
      zone,
    ]
  }
}

resource "azurerm_mysql_flexible_database" "mysql_database" {
  count               = 4
  name                = "wordpress${count.index + 1}"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_flexible_server.mysql_flexible_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "mysql_firewall_rule" {
  name                = var.vm_nsg_whitelist_ips_ports[count.index].name
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_flexible_server.mysql_flexible_server.name
  start_ip_address    = var.vm_nsg_whitelist_ips_ports[count.index].source_ip
  end_ip_address      = var.vm_nsg_whitelist_ips_ports[count.index].source_ip
  count               = length(var.vm_nsg_whitelist_ips_ports) > 0 ? length(var.vm_nsg_whitelist_ips_ports) : 0
  depends_on = [
    azurerm_mysql_flexible_server.mysql_flexible_server
  ]
}

resource "azurerm_mysql_flexible_server_configuration" "server_parameters" {
  name                = var.server_parameters[count.index].name
  resource_group_name = azurerm_mysql_flexible_server.mysql_flexible_server.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql_flexible_server.name
  value               = var.server_parameters[count.index].value
  count               = length(var.server_parameters) > 0 ? length(var.server_parameters) : 0
}