variable "name" {
  description = "Network resource Name"
  type = string

}

variable "region" {
  description = "Region of the network resource "
  type = string

}

variable "resource_group" {
  description = "Resource group for network resource"
}

variable "security_rules" {
  description = "VMSS NSG rules"
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
  type = list
  default = ["Microsoft.Storage"]

}

variable "private_dns_name" {
  description = "private dns zone name"
  type = string
  default = "privatelink.mysql.database.azure.com"

}