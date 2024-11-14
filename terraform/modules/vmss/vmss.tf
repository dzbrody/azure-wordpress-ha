### vmss.tf

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  count               = 4
  name                = element(["proleaguenetwork", "putttour", "slappoker", "str33t"], count.index)
  resource_group_name = var.resource_group_name
  location            = var.location
  upgrade_mode        = var.upgrade_mode
  health_probe_id     = var.upgrade_mode == "Automatic" || var.upgrade_mode == "Rolling" ? azurerm_lb_probe.vmss[count.index].id : null
  sku                 = var.sku
  instances           = var.autoscaling_enabled == true ? var.instances : 1
  admin_username      = var.admin_username
  custom_data         = var.custom_data != "" ? var.custom_data : null
  zones               = var.zones
  zone_balance        = var.zone_balance

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  network_interface {
    name                      = element(["proleaguenetwork", "putttour", "slappoker", "str33t"], count.index)
    primary                   = true
    network_security_group_id = var.network_security_group_id

    ip_configuration {
      name                                   = element(["proleaguenetwork", "putttour", "slappoker", "str33t"], count.index)
      subnet_id                              = var.subnet_id
      primary                                = true
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool[count.index].id]
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
      max_batch_instance_percent        = 50
      max_unhealthy_instance_percent     = 50
      max_unhealthy_upgraded_instance_percent = 50
      pause_time_between_batches         = "PT10M"
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

  # NFS Mount for each server's wp_content
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /var/www/html/wp_content",
      "sudo mount -t nfs -o vers=4,hard,timeo=900,retrans=5 ${azurerm_storage_account.storage_account.primary_location_endpoint}/blog_${element([\"proleaguenetwork\", \"putttour\", \"slappoker\", \"str33t\"], count.index)} /var/www/html/wp_content"
    ]
    connection {
      type     = "ssh"
      user     = var.admin_username
      private_key = file(var.ssh_private_key_path)
      host     = self.virtual_machine_scale_set.0.ip_configuration.0.public_ip_address
    }
  }
}