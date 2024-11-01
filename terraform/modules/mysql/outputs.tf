output "database_host" {
  value = azurerm_mysql_flexible_server.mysql_flexible_server.fqdn
}

output "database_user" {
  value = azurerm_mysql_flexible_server.mysql_flexible_server.administrator_login
}