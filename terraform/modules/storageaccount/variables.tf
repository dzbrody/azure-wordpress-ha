variable "resource_group" {
  description = "Resource group for storage account."
}

variable "storage_account_name" {
  description = "Name of storage account."
}

variable "region" {
  description = "Region of storage account."
  default     = "eastus"
}

variable "account_tier" {
  description = "Tier of the storage account."
  default     = "Standard"
}

variable "enable_https_traffic_only" {
  description = "Enable https-only traffic."
  default     = false
}

variable "account_replication_type" {
  description = "Replication type of account."
  default     = "LRS"
}

variable "containers" {
  description = "Containers to create into storage account"
  default     = []
}

variable "public_network_access_enabled" {
  description = "Allow public access to blobs inside the account"
  default     = true
}
variable "account_kind" {
  description = "Kind of account."
  default     = "Storage"
}

variable "is_hns_enabled" {
  description = "Enable/disable hierarchical namespace (true for datalake)."
  default     = false
}

variable "containers_datalake_gen2" {
  description = "List of containers to create into gen2 format."
  default     = []
}

variable "tags" {
  description = "(Optional) Map of tags and values to apply to the resource"
  type        = map(any)
  default     = {}
}


variable "network_rules" {
  description = "List of network rules for the storage account"
  type        = list(any)
  default     = []
}

variable "nfsv3_enabled" {
  description = "enable/disable nfs3 support to storage account"
  type        = bool
  default     = false

}

variable "min_tls_version" {
  description = "Min tls version for storage accounts"
  type        = string
  default     = "TLS1_2"

}

variable "enable_lock" {
  description = "Choose to lock the storage account for deletion"
  type        = bool
  default     = false

}

variable "subnet_id_private_endpoint" {
  description = "subnet for the private endpoint"
  type        = string
  default     = null
}

variable "name_private_link_dns" {
  description = "Name private link DNS"
  type        = string
  default     = null
}

variable "subresource_names_private_endpoint" {
  description = "Name for the resource to create the private endpoint"
  type        = list(any)
  default     = ["blob"]
}

variable "name_private_link_ids" {
  description = "ID private link DNS"
  type        = list(any)
  default     = []
}

variable "blob_properties" {
  description = "Properties to configure a blob storage account"
  type        = any
  default     = {}

}

variable "access_tier" {
  description = " Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts"
  type = string
  default = "Hot"
}