variable "vmss_name" {
  description = "virtual machine scale set name"

}
variable "location" {
  description = "Location of the vm scale set"
  type        = string
}

variable "resource_group_name" {
  description = "Name of Resource Group"
  type        = string
}

variable "sku" {
  description = "SKU of the vm scale set"
  type        = string
  default     = "Standard_B2s"
}

variable "autoscaling_enabled" {
  description = "Enable VMSS autoscaling"
  type        = bool
  default     = false
}

variable "instances" {
  description = "The number of Virtual Machines in the Scale Set"
  type        = number
  default     = 1
}

variable "upgrade_mode" {
  description = "VM upgrade mode"
  type        = string
  default     = "Manual"

}

variable "admin_username" {
  description = "Admin username"
  type        = string
  default     = "digimalls"

}

variable "ssh_public_key" {
  description = "Admin user ssh public key"
  type        = string
}

variable "custom_data" {
  description = "Custom data Script"
  type        = string
  default     = ""
}

variable "zones" {
  description = "zones to place the virtual machine scale set"
  type        = list(any)
  default     = ["1","2","3"]
}

variable "zone_balance" {
  description = "Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones?"
  type        = bool
  default     = false

}

variable "subnet_id" {
  description = "Virtual Machine Scale Set subnet id"
  type        = string

}

variable "os_disk_caching" {
  description = "The Type of Caching which should be used for the Internal OS Dis"
  type        = string
  default     = "ReadWrite"

}
variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk"
  type        = string
  default     = "StandardSSD_LRS"

}

variable "os_publisher" {
  description = "The publisher of the image used to create the virtual machines"
  type        = string
  default     = "Canonical"

}

variable "os_offer" {
  description = "the offer of the image used to create the virtual machines"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "os_sku" {
  description = "the SKU of the image used to create the virtual machines"
  type        = string
  default     = "22_04-lts-gen2"
}

variable "os_version" {
  description = "Specifies the version of the image used to create the virtual machines"
  type        = string
  default     = "latest"
}

variable "capacity_default" {
  description = "autoscaling default capacity"
  type        = number
  default     = 1

}

variable "capacity_minimum" {
  description = "autoscaling minimum capacity"
  type        = number
  default     = 1

}

variable "capacity_maximum" {
  description = "autoscaling maximum capacity"
  type        = number
  default     = 2

}

variable "metrics_trigger" {
  description = "metrics to trigger autoscaling"
  type        = list(any)
}

variable "autoscaling_email_notification_enabled" {
  description = "Email when autoscaling is triggered"
  type        = bool
  default     = false
}

variable "autoscaling_notification_email" {
  description = "Autoscaling email notification recipient"
  type        = list(any)
  default     = []
}
variable "tags" {
  description = "(Optional) Map of tags and values to apply to the resource"
  type        = map(string)
  default     = {}
}

variable "application_port" {
  description = "Application port for the health probe"
  type        = number
  default     = 80
}

variable "pip_sku" {
  description = "Public ip address SKU"
  type        = string
  default     = "Standard"
}

variable "lb_sku" {
  description = "Load balancer SKU"
  type        = string
  default     = "Standard"
}

variable "network_security_group_id" {
  description = "nsg ID for the vmss"
  type = string

}

variable "workspace_id" {
  description = "Log analytics workspace id for the vmss monitoring"
  type        = string
  default     = ""
}

variable automatic_instance_repair {
  description = "Enable auto instance repair"
  type = bool
  default = false
}

variable "public_lb" {
  description = "IF the load balancer is public"
  type = bool
  default = false

}

variable "lb_subnet_id" {
  description = "subnet id for the load balancer in case is internal"
  type = string
  default = ""

}
