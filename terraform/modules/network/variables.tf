variable "name" {
  description = "Network resource Name"
  type        = string
}

variable "region" {
  description = "Region of the network resource "
  type        = string
}

variable "resource_group" {
  description = "Resource group for network resource"
  type        = string
}

variable "security_rules" {
  description = "Network Security Group (NSG) security rules for the resources"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "(Optional) Map of tags and values to apply to the resource"
  type        = map(string)
  default     = {}
}

variable "service_endpoints" {
  description = "Service endpoints for the subnet"
  type        = list(string)
  default     = ["Microsoft.Storage"]
}

variable "private_dns_name" {
  description = "Private DNS zone name for MySQL server"
  type        = string
  default     = "privatelink.mysql.database.azure.com"
}

variable "vnet_address_space" {
  description = "The address space that is used by the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "vm_subnet_address_prefix" {
  description = "Address prefix for the VM subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "mysql_subnet_address_prefix" {
  description = "Address prefix for the MySQL subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "storage_subnet_address_prefix" {
  description = "Address prefix for the storage subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "vm_admin_username" {
  description = "Admin username for the virtual machines"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "Public SSH key for virtual machine access"
  type        = string
}
