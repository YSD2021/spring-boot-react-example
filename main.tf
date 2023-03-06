provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "example" {
  name     = "BH-resources"
  location = "West Europe"
}

resource "azurerm_container_registry" "acr" {
  name                = "AdeolaReg"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Premium"
  admin_enabled       = false
  georeplications {
    location                = "East US"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "West Europe"
    zone_redundancy_enabled = true
    tags                    = {}
  }
}
