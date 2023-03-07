# Create a Resource Group
resource "azurerm_resource_group" "acr-rg" {
  name = var.resource_group_name
  location = var.location  
}

# web App
resource "azurerm_app_service" "app-service" {
  name = var.web_app_name
  location = azurerm_resource_group.acr-rg.location
  resource_group_name = azurerm_resource_group.acr-rg.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.acr.admin_password
  
  }
  # Configure Docker Image to load on start
  site_config {
    linux_fx_version = "DOCKER|${var.registry_name}:${var.tag_name}"
    always_on        = "true"
  }
}