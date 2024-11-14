variable "resource_group" {
  description = "resource group for azure resources"
  default     = "DIGIMALLS_CUPOM_DEV"
}

variable "region" {
  description = "Region of database."
  default     = "eastus"
}

variable "resource_mysql_name" {
  description = "Name of database resource mysql"
}

variable "database_name" {
  description = "Database name to create"
}

variable "database_sku" {
  description = "Database SKU name"
  default     = "GP_Gen5_4"
}

variable "database_mysql_version" {
  description = "MySQL version"
  default     = "8.0"
}

variable "auto_grow" {
  description = "Enable/disable autogrow storage database."
  default     = false
}

variable "backup_retention_days" {
  description = "Number of days for backup retention."
  default     = 7
}

variable "geo_redundant_backup" {
  description = "Enable/disable geo redundant backup"
  default     = false
}

variable "database_mysql_admin_username" {
  description = "Database admin user"
}

variable "database_mysql_admin_password" {
  description = "Database admin password"
  default     = "Awvn==615@t0r0nt0"
}

variable "vm_nsg_whitelist_ips_ports" {
  description = "List of IPs allowed to connect into database server."
  default     = []
}

variable "create_replica" {
  description = "Create a replica database"
  default     = false
}

variable "replica_database_sku" {
  description = "Replica database SKU if different from the original one"
  type        = string
  default     = ""
}

variable "replica_region" {
  description = "Region for the replica database"
  default     = "westus"
}

variable "tags" {
  description = "(Optional) Map of tags and values to apply to the resource."
  type        = map(any)
  default     = {}
}

variable "virtual_network_id" {
  description = "VNet for the MySQL server in case it will be internally linked"
  type        = string
  default     = "pg_vnet"
}

variable "subnet_id" {
  description = "(Optional) Database subnet ID to inject"
  type        = string
  default     = ""
}

variable "private_dns_zone_id" {
  description = "(Optional) Database private DNS zone to link"
  type        = string
  default     = ""
}

variable "iops" {
  description = "Max IOPS for the database server"
  type        = string
  default     = "360"
}

variable "size_gb" {
  description = "Database server max size in GB"
  type        = string
}

variable "high_availability_enabled" {
  description = "Enable high availability"
  type        = bool
  default     = false
}

variable "ha_mode" {
  description = "High availability mode"
  type        = string
  default     = "ZoneRedundant"
}

variable "mysql_zone" {
  description = "Zone to place the MySQL server"
  type        = string
  default     = "1"
}

variable "mysql_replica_zone" {
  description = "Zone to place the MySQL replica server (if exists)"
  type        = string
  default     = "2"
}

variable "server_parameters" {
  description = "MySQL server parameters"
  type        = list(any)
  default     = []
}
