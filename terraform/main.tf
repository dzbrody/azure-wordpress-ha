terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.50.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

locals {
  region = "eastus2"
  tags   = {}
}

module "resource_group" {
  source = "./modules/resource_group"
  name   = "PLN-Wordpress"
  region = local.region
}

module "network" {
  source         = "./modules/network"
  name           = "wordpress-network"
  resource_group = module.resource_group.rg_name
  region         = local.region
  security_rules = [
    {
      name                       = "AllowHttp"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 80
      source_address_prefix      = "AzureFrontDoor.Backend"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowHttpVictor"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = 80
      source_address_prefix      = "187.107.71.146"
      destination_address_prefix = "*"
    }
  ]
}

module "storageaccount" {
  source = "./modules/storageaccount"

  resource_group            = module.resource_group.rg_name
  storage_account_name      = "wordpressstorage"
  region                    = local.region
  account_tier              = "Standard"
  account_replication_type  = "ZRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = false # Unsupported with NFS
  is_hns_enabled            = true
  nfsv3_enabled             = true
  enable_lock               = true
  containers = [
    {
      name                  = "wordpress-content"
      container_access_type = "private"
    },
    {
      name                  = "wordpress-content-bkp-weekly"
      container_access_type = "private"
    },
    {
      name                  = "wordpress-content-bkp-monthly"
      container_access_type = "private"
    }
  ]
  network_rules = [
    {
      default_action = "Deny"
      ip_rules       = ["187.107.71.146"]
      virtual_network_subnet_ids = [
        module.network.subnet_id
      ]
    }
  ]

  tags = local.tags

  # Added 4 storage shares for each domain
  shares = [
    {
      name  = "blog_proleaguenetwork"
      quota = 500
    },
    {
      name  = "blog_putttour"
      quota = 500
    },
    {
      name  = "blog_slappoker"
      quota = 500
    },
    {
      name  = "blog_str33t"
      quota = 500
    }
  ]
}

module "vmss" {
  source = "./modules/vmss"
  depends_on = [
    module.storageaccount
  ]
  location                  = local.region
  resource_group_name       = module.resource_group.rg_name
  sku                       = "Standard_B2s"
  zones                     = ["1", "2", "3"]
  upgrade_mode              = "Rolling"
  automatic_instance_repair = true
  custom_data               = filebase64("${path.root}/script.tpl")
  subnet_id                 = module.network.subnet_id
  network_security_group_id = module.network.nsg_id
  ssh_public_key            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvQRluXF3TIK00twfnhL1dIS263+JUKXEFh6jV1xuVUFqZMKKyCEoxg+7B1juiUBLETRb1CWcoLMPYZDjyyEheC6LM5rAH2PIBYxujzNx6b82h+NEMEI5mF45HE+NPsnDdOwBTMYFYt0jGOG9/Z5Eqkv0EL5kBX75cvAbATBIVfA8Zocny9mIP/tAFjNQ8hqc+rYnjfrH8ex+p8fREofPARNC7VTPICM7+/ia2h6H/XqFvSxJm7x3pMKbYsbjjduuUIpGK5GzDBKxz+NOZCYHIAwJk1VYa/K/2ZVzqjpTQQapnJ+9GmJHuyuq4qYB/ACPphqInZRjvwG74qEVv9GzvTDH7RmZHj7f2v/XrQ6iA7iB+eJesm5OlJLn29YLwEsOWzgmPIIzkvvF9nviCPxK2zjx0nnJ9/wOEJkxSsT97BhUWWZNnyjgIRMyWQxhPvyQVv1OAeXqJdrLlRO1uC800KSOL/+LHDA5KFRq+0snk5L+P4/sssb9wnhPPBRoi2Is="
  autoscaling_enabled       = true
  capacity_default          = 1
  capacity_minimum          = 1
  capacity_maximum          = 1

  metrics_trigger = [
    {
      name                   = "Percentage CPU"
      time_grain             = "PT1M"
      statistic              = "Average"
      time_window            = "PT5M"
      time_aggregation       = "Average"
      operator               = "GreaterThan"
      threshold              = 75
      frequency              = "PT1M"
      scale_action_direction = "Increase"
      scale_action_type      = "ChangeCount"
      scale_action_value     = "1"
      scale_action_cooldown  = "PT15M"
    },
    {
      name                   = "Percentage CPU"
      time_grain             = "PT1M"
      statistic              = "Average"
      time_window            = "PT20M"
      time_aggregation       = "Average"
      operator               = "LessThan"
      threshold              = 30
      frequency              = "PT1M"
      scale_action_direction = "Decrease"
      scale_action_type      = "ChangeCount"
      scale_action_value     = "1"
      scale_action_cooldown  = "PT15M"
    }
  ]

  tags = local.tags
}

module "azure-mysql" {
  source                        = "./modules/mysql"
  resource_group                = module.resource_group.rg_name
  region                        = local.region
  resource_mysql_name           = "mysql-wordpress1"
  database_name                 = "wordpress"
  database_sku                  = "GP_Standard_D2ds_v4"
  database_mysql_version        = "8.0.21"
  size_gb                       = "20"
  auto_grow                     = true
  backup_retention_days         = 20
  geo_redundant_backup          = false
  high_availability_enabled     = true
  database_mysql_admin_username = "adminsiteswordpress"
  database_mysql_admin_password = "Awvn==615@t0r0nt0" # Hardcoded password, removed unnecessary variable
  tags                          = local.tags
  vm_nsg_whitelist_ips_ports = [{
    "name"      = "vmss_ip"
    "source_ip" = module.vmss.lb_ip
  }]
  server_parameters = [
    {
      name  = "require_secure_transport"
      value = "OFF"
    }
  ]
}
