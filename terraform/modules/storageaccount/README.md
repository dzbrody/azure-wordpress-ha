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
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Kind of account. | `string` | `"Storage"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Replication type of account. | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Tier of the storage account. | `string` | `"Standard"` | no |
| <a name="input_blob_properties"></a> [blob\_properties](#input\_blob\_properties) | Properties to configure a blob storage account | `any` | `{}` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | Containers to create into storage account | `list` | `[]` | no |
| <a name="input_containers_datalake_gen2"></a> [containers\_datalake\_gen2](#input\_containers\_datalake\_gen2) | List of containers to create into gen2 format. | `list` | `[]` | no |
| <a name="input_enable_https_traffic_only"></a> [enable\_https\_traffic\_only](#input\_enable\_https\_traffic\_only) | Enable https-only traffic. | `bool` | `false` | no |
| <a name="input_enable_lock"></a> [enable\_lock](#input\_enable\_lock) | Choose to lock the storage account for deletion | `bool` | `false` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | Enable/disable hierarchical namespace (true for datalake). | `bool` | `false` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | Min tls version for storage accounts | `string` | `"TLS1_2"` | no |
| <a name="input_name_private_link_dns"></a> [name\_private\_link\_dns](#input\_name\_private\_link\_dns) | Name private link DNS | `string` | `null` | no |
| <a name="input_name_private_link_ids"></a> [name\_private\_link\_ids](#input\_name\_private\_link\_ids) | ID private link DNS | `list(any)` | `[]` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | List of network rules for the storage account | `list(any)` | `[]` | no |
| <a name="input_nfsv3_enabled"></a> [nfsv3\_enabled](#input\_nfsv3\_enabled) | enable/disable nfs3 support to storage account | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Allow public access to blobs inside the account | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | Region of storage account. | `string` | `"eastus"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource group for storage account. | `any` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Name of storage account. | `any` | n/a | yes |
| <a name="input_subnet_id_private_endpoint"></a> [subnet\_id\_private\_endpoint](#input\_subnet\_id\_private\_endpoint) | subnet for the private endpoint | `string` | `null` | no |
| <a name="input_subresource_names_private_endpoint"></a> [subresource\_names\_private\_endpoint](#input\_subresource\_names\_private\_endpoint) | Name for the resource to create the private endpoint | `list(any)` | <pre>[<br>  "blob"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Map of tags and values to apply to the resource | `map(any)` | `{}` | no |

## Outputs

No outputs.