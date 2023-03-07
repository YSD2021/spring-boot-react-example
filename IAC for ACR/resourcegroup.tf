# Resources to be shared (eg ACR)
resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}resource-group"
  location = "West Europe"
}

