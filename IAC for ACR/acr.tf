
resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}registry"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"
  admin_enabled       = true
}