resource "azurerm_service_plan" "my_service_plan" {
  name                = "Ade-BH-AppPlan"
  resource_group_name = "AdeolaBHresource-group"
  location            = "westeurope"
  os_type             = "Linux"
  sku_name            = "s1"
}

  data "azurerm_container_registry" "registry" {
  name                = "adeolabhregistry"
  resource_group_name = "AdeolaBHresource-group"
}
resource "azurerm_app_service" "backend" {
 name                = "Ade-BH-App"
 location            = azurerm_service_plan.my_service_plan.location
 resource_group_name     = azurerm_service_plan.my_service_plan.resource_group_name
 app_service_plan_id     = azurerm_service_plan.my_service_plan.id
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
    linux_fx_version = "DOCKER|adeolabhregistry.azurecr.io/adeimage-ysd2021/spring-boot-react-example:82"
  }
  }