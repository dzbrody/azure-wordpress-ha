resource "azurerm_frontdoor" "frontdoor" {
name                                         = var.frontdoor_name
resource_group_name                          = var.resource_group
friendly_name       = var.friendly_name != null ? var.friendly_name : null
tags  = var.tags
load_balancer_enabled = var.load_balancer_enabled

backend_pool_settings {
enforce_backend_pools_certificate_name_check = var.backend_pools_certificate_name_check_enforced
backend_pools_send_receive_timeout_seconds   = var.backend_pools_send_receive_timeout_seconds
}


dynamic routing_rule {
for_each = var.routing_rules
content {
name               = lookup(routing_rule.value, "name")
accepted_protocols = lookup(routing_rule.value, "accepted_protocols")
patterns_to_match  = lookup(routing_rule.value, "patterns_to_match", ["/*"])
frontend_endpoints = lookup(routing_rule.value, "frontend_endpoints")
dynamic "forwarding_configuration" {
for_each = lookup(routing_rule.value, "forwarding_configurations", [])
content {
backend_pool_name                     = lookup(forwarding_configuration.value, "backend_pool_name")
cache_enabled                         = lookup(forwarding_configuration.value, "cache_enabled", false)
cache_use_dynamic_compression         = lookup(forwarding_configuration.value, "cache_use_dynamic_compression", false)
cache_query_parameter_strip_directive = lookup(forwarding_configuration.value, "cache_query_parameter_strip_directive", "StripAll")
cache_query_parameters                = lookup(forwarding_configuration.value, "cache_query_parameters", null)
cache_duration                        = lookup(forwarding_configuration.value, "cache_duration", null)
custom_forwarding_path                = lookup(forwarding_configuration.value, "custom_forwarding_path", null)
forwarding_protocol                   = lookup(forwarding_configuration.value, "forwarding_protocol", "MatchRequest")
}
}
dynamic "redirect_configuration" {
for_each = lookup(routing_rule.value, "redirect_configurations", [])
content {
custom_host         = lookup(redirect_configuration.value, "custom_host", null)
redirect_protocol   = lookup(redirect_configuration.value, "redirect_protocol", "MatchRequest")
redirect_type       = lookup(redirect_configuration.value, "redirect_type", "Found")
custom_fragment     = lookup(redirect_configuration.value, "custom_fragment", null)
custom_path         = lookup(redirect_configuration.value, "custom_path", null)
custom_query_string = lookup(redirect_configuration.value, "custom_query_string", null)
}
}
}
}

dynamic backend_pool_load_balancing {
for_each = var.backend_pool_load_balancings
content {
name = lookup(backend_pool_load_balancing.value, "name")
sample_size                     = lookup(backend_pool_load_balancing.value, "sample_size", 4)
successful_samples_required     = lookup(backend_pool_load_balancing.value, "successful_samples_required", 2)
additional_latency_milliseconds = lookup(backend_pool_load_balancing.value, "additional_latency_milliseconds", 0)
}
}

dynamic backend_pool_health_probe {
for_each = var.backend_pool_health_probes
content {
name = lookup(backend_pool_health_probe.value, "name")
enabled             = lookup(backend_pool_health_probe.value, "enabled", true)
path                = lookup(backend_pool_health_probe.value, "path", "/")
protocol            = lookup(backend_pool_health_probe.value, "protocol", "Http")
probe_method        = lookup(backend_pool_health_probe.value, "probe_method", "GET")
interval_in_seconds = lookup(backend_pool_health_probe.value, "interval_in_seconds", 120)
}
}

dynamic backend_pool {
for_each = var.backend_pools
content {
name = lookup(backend_pool.value, "name")
load_balancing_name = lookup(backend_pool.value, "load_balancing_name")
health_probe_name = lookup(backend_pool.value, "health_probe_name")

dynamic "backend" {
for_each = lookup(backend_pool.value, "backends")
# To Change
# for_each = var.backend_pool_backends
content {
enabled     = lookup(backend.value, "enabled", true)
address     = lookup(backend.value, "address")
host_header = lookup(backend.value, "host_header","")
http_port   = lookup(backend.value, "http_port", 80)
https_port  = lookup(backend.value, "https_port", 443)
priority    = lookup(backend.value, "priority", null)
weight      = lookup(backend.value, "weight", null)
}
}
}
}

dynamic frontend_endpoint {
for_each = var.frontend_endpoints
content {
name                                    = lookup(frontend_endpoint.value, "name", null)
host_name                               = lookup(frontend_endpoint.value, "host_name", null)
session_affinity_enabled                = lookup(frontend_endpoint.value, "session_affinity_enabled", false)
session_affinity_ttl_seconds            = lookup(frontend_endpoint.value, "session_affinity_ttl_seconds", 0)
web_application_firewall_policy_link_id = lookup(frontend_endpoint.value, "web_application_firewall_policy_link_id", null)
}
}
}


resource "azurerm_frontdoor_custom_https_configuration" "custom_https_configuration" {
for_each = { for fe in var.frontend_endpoints : fe.name => fe if try(fe["custom_https_configuration"], null) != null }

frontend_endpoint_id = format("%s/frontendEndpoints/%s", azurerm_frontdoor.frontdoor.id, each.key)

custom_https_provisioning_enabled = true

custom_https_configuration {
certificate_source = try(each.value["custom_https_configuration"]["certificate_source"], "FrontDoor")

azure_key_vault_certificate_vault_id       = try(each.value["custom_https_configuration"]["azure_key_vault_certificate_vault_id"], null)
azure_key_vault_certificate_secret_name    = try(each.value["custom_https_configuration"]["azure_key_vault_certificate_secret_name"], null)
azure_key_vault_certificate_secret_version = try(each.value["custom_https_configuration"]["azure_key_vault_certificate_secret_version"], null)
}
}