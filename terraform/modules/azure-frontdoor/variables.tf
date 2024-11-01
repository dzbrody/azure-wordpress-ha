variable "frontdoor_name" {
  description = "Name of the frontdoor"
  type        = string
}

variable "resource_group" {
  description = "Resource group name"
  type        = string

}

variable "friendly_name" {
  description = "FrontDoor Friendly name"
  type = string
  default = ""

}
variable "backend_pools_certificate_name_check_enforced" {
  description = "Enforce certificate name check on HTTPS requests to all backend pools"
  type        = bool
  default     = false
}

variable "backend_pools_send_receive_timeout_seconds" {
  description = "Specifies the send and receive timeout on forwarding request to the backend"
  type        = number
  default     = 60
}
variable "tags" {
  description = "(Optional) Map of tags and values to apply to the resource"
  type        = map(string)
  default     = {}
}


variable "routing_rule_name" {
  description = "name for the routing rule"
  type        = string
  default     = "default"
}

variable "accepted_protocols" {
  description = "Protocols accepted by the routing rule"
  type        = list(any)
  default     = ["Https"]
}

variable "backend_pool_name" {
  description = "name for the backend pool"
  type        = string
  default     = "default"
}

variable "backend_pool_load_balancing" {
  description = "backend pool load balancing name"
  type        = string
  default     = "default"
}

variable "backend_pool_health_probe" {
  description = "backend pool health probe"
  type        = string
  default     = "default"
}

variable "backend_pool_health_probe_enabled" {
  description = "backend pool health probe enabled"
  type        = bool
  default     = false
}

variable "backend_pool_health_probe_protocol" {
  description = "backend pool health probe protocol"
  type        = string
  default     = "Http"
}

variable "backend_pool_health_probe_path" {
  description = "backend pool health probe path"
  type        = string
  default     = "/"

}
variable "backend_enabled" {
  description = "Enable backend"
  type        = bool
  default     = true
}

variable "frontend_endpoint_name" {
  description = "frontend endpoint name"
  type        = string
  default     = "default"
}

variable "certificate_source" {
  description = "Source from the ssl certificate"
  type        = string
  default     = "AzureKeyVault"
}

variable "azure_key_vault_certificate_secret_name" {
  description = "Key vault certificate name"
  type        = string
  default     = ""
}

variable "key_vault_id" {
  description = "Id from the key vault"
  type        = string
  default     = ""
}

# variable "azure_key_vault_certificate_secret_version" {
#     description = "SSL certificate version"
#     type = string
#     default = "Latest"
# }

variable "custom_domain_enable" {
  description = "Enable custom domain"
  type        = bool
  default     = false
}

variable "backend_pools" {
  description = "A list of backend_pool blocks."
  type        = list(any)
}

variable "backend_pool_health_probes" { # required
  description = "A list of backend_pool_health_probe blocks."
  type        = list(map(string))
  default = [{ "default" = "default" }] # fake list of map, if enable_default_backend_pools_parameters take default probe values
}

variable "backend_pool_load_balancings" { # required
  description = "A list of backend_pool_load_balancing blocks."
  type        = list(map(string))
  default = [{ "default" = "default" }]
}

variable "frontend_endpoints" {
  description = "A list frontend_endpoint block."
  type        = list(any)
  default     = []

}

variable "routing_rules" {
  description = "A routing_rule block."
  type        = any
  default     = []
}

variable "load_balancer_enabled" { # optional
  description = "Should the Front Door Load Balancer be Enabled?"
  type        = bool
  default     = true
}


