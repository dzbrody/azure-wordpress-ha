output "lb_ip" {
  value = azurerm_public_ip.vmss.ip_address
}