output "login_server" {
  value = data.azurerm_container_registry.registry.login_server
}
output "admin_username" {
  value = data.azurerm_container_registry.registry.admin_username
}
output "admin_password" {
  value = data.azurerm_container_registry.registry.admin_password
}