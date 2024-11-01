## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.bpepool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_probe.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.lbnatrule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_linux_virtual_machine_scale_set.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.vmss_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_public_ip.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin username | `string` | `"digimalls"` | no |
| <a name="input_application_port"></a> [application\_port](#input\_application\_port) | Application port for the health probe | `number` | `80` | no |
| <a name="input_automatic_instance_repair"></a> [automatic\_instance\_repair](#input\_automatic\_instance\_repair) | Enable auto instance repair | `bool` | `false` | no |
| <a name="input_autoscaling_email_notification_enabled"></a> [autoscaling\_email\_notification\_enabled](#input\_autoscaling\_email\_notification\_enabled) | Email when autoscaling is triggered | `bool` | `false` | no |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | Enable VMSS autoscaling | `bool` | `false` | no |
| <a name="input_autoscaling_notification_email"></a> [autoscaling\_notification\_email](#input\_autoscaling\_notification\_email) | Autoscaling email notification recipient | `list(any)` | `[]` | no |
| <a name="input_capacity_default"></a> [capacity\_default](#input\_capacity\_default) | autoscaling default capacity | `number` | `1` | no |
| <a name="input_capacity_maximum"></a> [capacity\_maximum](#input\_capacity\_maximum) | autoscaling maximum capacity | `number` | `2` | no |
| <a name="input_capacity_minimum"></a> [capacity\_minimum](#input\_capacity\_minimum) | autoscaling minimum capacity | `number` | `1` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | Custom data Script | `string` | `""` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | The number of Virtual Machines in the Scale Set | `number` | `1` | no |
| <a name="input_lb_sku"></a> [lb\_sku](#input\_lb\_sku) | Load balancer SKU | `string` | `"Standard"` | no |
| <a name="input_lb_subnet_id"></a> [lb\_subnet\_id](#input\_lb\_subnet\_id) | subnet id for the load balancer in case is internal | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the vm scale set | `string` | n/a | yes |
| <a name="input_metrics_trigger"></a> [metrics\_trigger](#input\_metrics\_trigger) | metrics to trigger autoscaling | `list(any)` | n/a | yes |
| <a name="input_network_security_group_id"></a> [network\_security\_group\_id](#input\_network\_security\_group\_id) | nsg ID for the vmss | `string` | n/a | yes |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | The Type of Caching which should be used for the Internal OS Dis | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_os_offer"></a> [os\_offer](#input\_os\_offer) | the offer of the image used to create the virtual machines | `string` | `"0001-com-ubuntu-server-jammy"` | no |
| <a name="input_os_publisher"></a> [os\_publisher](#input\_os\_publisher) | The publisher of the image used to create the virtual machines | `string` | `"Canonical"` | no |
| <a name="input_os_sku"></a> [os\_sku](#input\_os\_sku) | the SKU of the image used to create the virtual machines | `string` | `"22_04-lts-gen2"` | no |
| <a name="input_os_version"></a> [os\_version](#input\_os\_version) | Specifies the version of the image used to create the virtual machines | `string` | `"latest"` | no |
| <a name="input_pip_sku"></a> [pip\_sku](#input\_pip\_sku) | Public ip address SKU | `string` | `"Standard"` | no |
| <a name="input_public_lb"></a> [public\_lb](#input\_public\_lb) | IF the load balancer is public | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of Resource Group | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU of the vm scale set | `string` | `"Standard_B2s"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | Admin user ssh public key | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Virtual Machine Scale Set subnet id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Map of tags and values to apply to the resource | `map(string)` | `{}` | no |
| <a name="input_upgrade_mode"></a> [upgrade\_mode](#input\_upgrade\_mode) | VM upgrade mode | `string` | `"Manual"` | no |
| <a name="input_vmss_name"></a> [vmss\_name](#input\_vmss\_name) | virtual machine scale set name | `any` | n/a | yes |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | Log analytics workspace id for the vmss monitoring | `string` | `""` | no |
| <a name="input_zone_balance"></a> [zone\_balance](#input\_zone\_balance) | Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones? | `bool` | `false` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | zones to place the virtual machine scale set | `list(any)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_ip"></a> [lb\_ip](#output\_lb\_ip) | n/a |