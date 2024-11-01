resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  resource_group_name = var.resource_group_name
  location            = var.location
  upgrade_mode        = var.upgrade_mode
  health_probe_id     = var.upgrade_mode == "Automatic" ||  var.upgrade_mode == "Rolling" ? azurerm_lb_probe.vmss.id : null
  sku                 = var.sku
  instances           = var.autoscaling_enabled == true ? var.instances : 0
  admin_username      = var.admin_username
  custom_data         = var.custom_data != "" ? var.custom_data : null
  zones               = var.zones
  zone_balance        = var.zone_balance


  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  network_interface {
    name                      = var.vmss_name
    primary                   = true
    network_security_group_id = var.network_security_group_id

    ip_configuration {
      name                                   = var.vmss_name
      subnet_id                              = var.subnet_id
      primary                                = true
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
    }
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }

  dynamic rolling_upgrade_policy {
    for_each = var.upgrade_mode == "Rolling" ? [1] : []
    content {
      max_batch_instance_percent = 50
      max_unhealthy_instance_percent = 50
      max_unhealthy_upgraded_instance_percent = 50
      pause_time_between_batches = "PT10M"
    }

  }

  dynamic automatic_instance_repair {
    for_each = var.automatic_instance_repair == true ? [1] : []
    content {
      enabled = true
    }

  }

  lifecycle {
    ignore_changes = [instances]
  }
  tags = var.tags
}
