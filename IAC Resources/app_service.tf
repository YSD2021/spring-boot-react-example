resource "azurerm_app_service_plan" "backend" {
  name                = "${local.name_prefix}-backend-appserviceplan"
  location            = azurerm_resource_group.backend-app.location
  resource_group_name = azurerm_resource_group.backend-app.name
  kind                = "Linux"
  reserved            = true # required for Linux plans, might need to be in a properties thing
  sku {
    tier = "Standard"
    size = "S1"
  }
}
resource "azurerm_app_service" "backend" {
  name                = "${local.name_prefix}-backend-app-service"
  location            = azurerm_resource_group.backend-app.location
  resource_group_name = azurerm_resource_group.backend-app.name
  app_service_plan_id = azurerm_app_service_plan.backend.id
  app_settings = {
    DOCKER_REGISTRY_SERVER_URL          = azurerm_container_registry.registry.login_server
    DOCKER_REGISTRY_SERVER_USERNAME     = azurerm_container_registry.registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD     = azurerm_container_registry.registry.admin_password
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = local.environmentvars["backend_port"]
  }
  site_config {
    always_on = "true"
    # define the images to used for you application
    linux_fx_version = "DOCKER|${azurerm_container_registry.registry.0.login_server}/${local.environmentvars["backend_image"]}:${local.environmentvars["backend_image_tag"]}"
  }
  }