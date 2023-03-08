resource "azurerm_service_plan" "my_service_plan" {
  name                = "Ade-BH-WebAppPlans"
  resource_group_name = "AdeolaBHresource-group"
  location            = "westeurope"
  os_type             = "Linux"
  sku_name            = "S1"
}

  data "azurerm_container_registry" "registry" {
  name                = "adeolabhregistry"
  resource_group_name = "AdeolaBHresource-group"
}
resource "azurerm_app_service" "backend" {
 name                = "Ade-BH-WebApps"
 location            = azurerm_service_plan.my_service_plan.location
 resource_group_name     = azurerm_service_plan.my_service_plan.resource_group_name
 app_service_plan_id     = azurerm_service_plan.my_service_plan.id
  app_settings = {
    DOCKER_REGISTRY_SERVER_URL          = data.azurerm_container_registry.registry.login_server
    DOCKER_REGISTRY_SERVER_USERNAME     = data.azurerm_container_registry.registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD     = data.azurerm_container_registry.registry.admin_password
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
  }
  site_config {
    always_on = "true"
    # define the images to used for you application
    linux_fx_version = "DOCKER|adeolabhregistry.azurecr.io/adeimage-ysd2021/spring-boot-react-example:82"
  }
  }
  resource "azurerm_application_insights" "insights" {
  name                = "BH-appinsights"
  location            = azurerm_service_plan.my_service_plan.location
  resource_group_name = azurerm_service_plan.my_service_plan.resource_group_name
  application_type    = "web"
}