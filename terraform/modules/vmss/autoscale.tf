### autoscale.tf

resource "azurerm_monitor_autoscale_setting" "vmss_autoscale" {
  name                = var.vmss_name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss.id

  profile {
    name = "defaultProfile"

    capacity {
      default = var.capacity_default
      minimum = var.capacity_minimum
      maximum = var.capacity_maximum
    }

    dynamic "rule" {
      for_each = var.metrics_trigger
      iterator = item
      content {
        metric_trigger {
          metric_name        = item.value.name
          metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
          time_grain         = item.value.time_grain
          statistic          = item.value.statistic
          time_window        = item.value.time_window
          time_aggregation   = item.value.time_aggregation
          operator           = item.value.operator
          threshold          = item.value.threshold
          metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        }

        scale_action {
          direction = item.value.scale_action_direction
          type      = item.value.scale_action_type
          value     = item.value.scale_action_value
          cooldown  = item.value.scale_action_cooldown
        }
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = var.autoscaling_email_notification_enabled
      send_to_subscription_co_administrator = var.autoscaling_email_notification_enabled
      custom_emails                         = var.autoscaling_notification_email
    }
  }
  tags  = var.tags
  count = var.autoscaling_enabled == true && length(var.metrics_trigger) > 0 ? 1 : 0
}
