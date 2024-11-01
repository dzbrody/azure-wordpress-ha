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
| [azurerm_mysql_flexible_database.mysql_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) | resource |
| [azurerm_mysql_flexible_server.mysql_flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server.mysql_flexible_server_replica](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server_configuration.server_parameters](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_configuration) | resource |
| [azurerm_mysql_flexible_server_firewall_rule.mysql_firewall_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_firewall_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_grow"></a> [auto\_grow](#input\_auto\_grow) | Enable/disable autogrow storage database. | `bool` | `false` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Number of days for backup retention. | `number` | `7` | no |
| <a name="input_create_replica"></a> [create\_replica](#input\_create\_replica) | Create a replica database | `bool` | `false` | no |
| <a name="input_database_mysql_admin_password"></a> [database\_mysql\_admin\_password](#input\_database\_mysql\_admin\_password) | Database admin password | `any` | n/a | yes |
| <a name="input_database_mysql_admin_username"></a> [database\_mysql\_admin\_username](#input\_database\_mysql\_admin\_username) | Database admin user | `any` | n/a | yes |
| <a name="input_database_mysql_version"></a> [database\_mysql\_version](#input\_database\_mysql\_version) | MySQL version | `string` | `"8.0"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Database name to create | `any` | n/a | yes |
| <a name="input_database_sku"></a> [database\_sku](#input\_database\_sku) | Database SKU name | `string` | `"GP_Gen5_4"` | no |
| <a name="input_geo_redundant_backup"></a> [geo\_redundant\_backup](#input\_geo\_redundant\_backup) | Enable/disable geo reduntant backup | `bool` | `false` | no |
| <a name="input_ha_mode"></a> [ha\_mode](#input\_ha\_mode) | High availability mode | `string` | `"ZoneRedundant"` | no |
| <a name="input_high_availability_enabled"></a> [high\_availability\_enabled](#input\_high\_availability\_enabled) | Enable high availability | `bool` | `false` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | Max Ios for the database server | `string` | `"360"` | no |
| <a name="input_mysql_replica_zone"></a> [mysql\_replica\_zone](#input\_mysql\_replica\_zone) | Zone to place the mysql replica server(if exists) | `string` | `"2"` | no |
| <a name="input_mysql_zone"></a> [mysql\_zone](#input\_mysql\_zone) | Zone to place the mysql server | `string` | `"1"` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | (Optional) Database private dns zone to link | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | Region of database. | `string` | `"eastus"` | no |
| <a name="input_replica_database_sku"></a> [replica\_database\_sku](#input\_replica\_database\_sku) | Replica database sku if differente from the original one | `string` | `""` | no |
| <a name="input_replica_region"></a> [replica\_region](#input\_replica\_region) | Region for the replica database | `string` | `"westus"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | resource group for azure resources | `string` | `"DIGIMALLS_CUPOM_DEV"` | no |
| <a name="input_resource_mysql_name"></a> [resource\_mysql\_name](#input\_resource\_mysql\_name) | Name of database resource mysql | `any` | n/a | yes |
| <a name="input_server_parameters"></a> [server\_parameters](#input\_server\_parameters) | Mysql server parameter | `list(any)` | `[]` | no |
| <a name="input_size_gb"></a> [size\_gb](#input\_size\_gb) | Database server max size in GB | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Optional)Database subnet id to inject | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Map of tags and values to apply to the resource. | `map(any)` | `{}` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | Vnet for the postgres server in case it will be internally linked | `string` | `"pg_vnet"` | no |
| <a name="input_vm_nsg_whitelist_ips_ports"></a> [vm\_nsg\_whitelist\_ips\_ports](#input\_vm\_nsg\_whitelist\_ips\_ports) | List of ip's allowed to connect into database server. | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_host"></a> [database\_host](#output\_database\_host) | n/a |
| <a name="output_database_user"></a> [database\_user](#output\_database\_user) | n/a |