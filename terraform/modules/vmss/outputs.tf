### outputs.tf

output "lb_ip" {
  value = [for public_ip in azurerm_public_ip.vmss : public_ip.ip_address]
}